#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(char * s){
    int freq[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }

    int freqs[count];
    int k = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            freqs[k++] = freq[i];
        }
    }

    int min_ops = n;
    for (int target = 1; target <= n; target++) {
        int ops = 0;
        for (int i = 0; i < count; i++) {
            if (freqs[i] > target) {
                ops += freqs[i] - target;
            } else if (freqs[i] < target) {
                ops += freqs[i];
            }
        }

        int valid = 1;
        int removed = 0;
        for (int i = 0; i < count; i++) {
            if (freqs[i] < target) {
                removed += freqs[i];
            }
        }

        if (ops - removed != 0) {
            valid = 0;
        }

        if (valid)
        {
           int curr_ops = 0;
            for (int i = 0; i < count; i++) {
                if (freqs[i] > target) {
                    curr_ops += freqs[i] - target;
                }
            }
            if (curr_ops < min_ops) {
                min_ops = curr_ops;
            }
        }

        int num_target = 0;
        int other_sum = 0;
        for(int i = 0; i < count; i++){
            if(freqs[i] == target){
                num_target++;
            } else {
                other_sum += freqs[i];
            }
        }

        if(other_sum == 0 && num_target > 0){
            if (0 < min_ops) {
                min_ops = 0;
            }
        }

    }

    int unique_freqs[26] = {0};
    for(int i = 0; i < count; i++){
        unique_freqs[freqs[i]] = 1;
    }

    int num_unique = 0;
    for(int i = 0; i < 26; i++){
        if(unique_freqs[i] == 1){
            num_unique++;
        }
    }

    if(num_unique == 1){
        return 0;
    }

    if (count == 1) return 0;

    return min_ops;
}