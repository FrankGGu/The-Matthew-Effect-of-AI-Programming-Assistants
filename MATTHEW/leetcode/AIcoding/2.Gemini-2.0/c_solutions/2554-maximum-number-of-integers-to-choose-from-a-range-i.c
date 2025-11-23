#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCount(int banned[], int bannedSize, int n, int maxSum) {
    int count = 0;
    int sum = 0;
    char *used = (char*)calloc(n + 1, sizeof(char));

    for (int i = 0; i < bannedSize; i++) {
        if (banned[i] <= n) {
            used[banned[i]] = 1;
        }
    }

    for (int i = 1; i <= n; i++) {
        if (used[i] == 0) {
            if (sum + i <= maxSum) {
                sum += i;
                count++;
            } else {
                break;
            }
        }
    }

    free(used);
    return count;
}