#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSpecialEquivGroups(char ** A, int ASize){
    int count = 0;
    int *seen = (int*)calloc(ASize, sizeof(int));

    for (int i = 0; i < ASize; i++) {
        if (seen[i]) continue;
        count++;
        seen[i] = 1;

        for (int j = i + 1; j < ASize; j++) {
            if (seen[j]) continue;
            if (strlen(A[i]) != strlen(A[j])) continue;

            int len = strlen(A[i]);
            int even1[26] = {0}, odd1[26] = {0};
            int even2[26] = {0}, odd2[26] = {0};

            for (int k = 0; k < len; k++) {
                if (k % 2 == 0) {
                    even1[A[i][k] - 'a']++;
                    even2[A[j][k] - 'a']++;
                } else {
                    odd1[A[i][k] - 'a']++;
                    odd2[A[j][k] - 'a']++;
                }
            }

            int equiv = 1;
            for (int k = 0; k < 26; k++) {
                if (even1[k] != even2[k] || odd1[k] != odd2[k]) {
                    equiv = 0;
                    break;
                }
            }

            if (equiv) {
                seen[j] = 1;
            }
        }
    }

    free(seen);
    return count;
}