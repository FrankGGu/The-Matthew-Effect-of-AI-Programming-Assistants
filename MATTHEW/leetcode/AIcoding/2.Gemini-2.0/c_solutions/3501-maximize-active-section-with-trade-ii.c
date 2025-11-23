#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximizeActiveSections(int* charges, int chargesSize, int r) {
    int n = chargesSize;
    int* diffs = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        diffs[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        diffs[i] += charges[i];
        if (i - r >= 0) {
            diffs[i] -= charges[i - r];
        }
        if (i + r < n) {
            diffs[i] -= charges[i + r];
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (charges[i] == 1) {
            count++;
        }
    }

    int max_count = 0;
    for (int i = 0; i < n; i++) {
        int current_count = 0;
        for (int j = 0; j < n; j++) {
            if (charges[j] == 1) {
                current_count++;
            }
        }

        int original_charge_i = charges[i];
        charges[i] = 1 - charges[i];

        int new_count = 0;
        for (int j = 0; j < n; j++) {
            if (charges[j] == 1) {
                new_count++;
            }
        }

        if (new_count > max_count) {
            max_count = new_count;
        }

        charges[i] = original_charge_i;
    }

    max_count = count;

    for(int i = 0; i < n; i++){
        int temp_count = 0;
        int original = charges[i];
        charges[i] = 1 - charges[i];

        for(int j = 0; j < n; j++){
            if(charges[j] == 1){
                temp_count++;
            }
        }

        if(temp_count > max_count){
            max_count = temp_count;
        }

        charges[i] = original;
    }

    free(diffs);
    return max_count;
}