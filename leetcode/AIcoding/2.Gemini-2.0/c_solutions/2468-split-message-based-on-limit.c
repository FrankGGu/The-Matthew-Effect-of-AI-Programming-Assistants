#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **splitMessage(char *message, int limit, int *returnSize) {
    int n = strlen(message);
    int count = 0;
    int digits = 0;
    int low = 1, high = n;
    int k = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        long long len = 0;
        for (int i = 1; i <= mid; i++) {
            int d = 0;
            int temp = i;
            while (temp > 0) {
                d++;
                temp /= 10;
            }
            len += strlen(message) + 1 >= limit ? limit - d - 3 : strlen(message) + 1 - d -3;
        }

        if (len >= n) {
            k = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    if (k == 0) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(k * sizeof(char *));
    *returnSize = k;

    int start = 0;
    for (int i = 1; i <= k; i++) {
        int d = 0;
        int temp = i;
        while (temp > 0) {
            d++;
            temp /= 10;
        }

        int len = strlen(message) + 1 >= limit ? limit - d - 3 : strlen(message) + 1 - d -3;
        len = fmin(len, n - start);

        result[i - 1] = (char *)malloc((len + 1) * sizeof(char));
        strncpy(result[i - 1], message + start, len);
        result[i - 1][len] = '\0';

        int suffix_len = 0;
        int temp2 = k;
        while (temp2 > 0) {
            suffix_len++;
            temp2 /= 10;
        }

        char suffix[15];
        sprintf(suffix, "<%d/%d>", i, k);

        int total_len = strlen(result[i - 1]) + strlen(suffix);
        char *temp_str = (char *)malloc((total_len + 1) * sizeof(char));
        strcpy(temp_str, result[i - 1]);
        strcat(temp_str, suffix);

        free(result[i - 1]);
        result[i - 1] = temp_str;

        start += len;
    }

    return result;
}