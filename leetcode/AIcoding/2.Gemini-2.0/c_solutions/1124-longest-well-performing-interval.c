#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestWPI(int* hours, int hoursSize){
    int max_len = 0;
    int sum = 0;
    int *hash = (int *)malloc(sizeof(int) * (2 * hoursSize + 1));
    for (int i = 0; i < 2 * hoursSize + 1; i++) {
        hash[i] = -2;
    }
    hash[hoursSize] = -1;
    for (int i = 0; i < hoursSize; i++) {
        if (hours[i] > 8) {
            sum++;
        } else {
            sum--;
        }
        if (hash[sum + hoursSize] == -2) {
            hash[sum + hoursSize] = i;
        }
        if (sum > 0) {
            max_len = i + 1;
        } else if (hash[sum + hoursSize - 1] != -2) {
            max_len = (max_len > (i - hash[sum + hoursSize - 1])) ? max_len : (i - hash[sum + hoursSize - 1]);
        }
    }
    free(hash);
    return max_len;
}