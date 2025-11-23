#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

char* nearestPalindromic(char* n) {
    int len = strlen(n);
    if (len == 1) {
        char* res = (char*)malloc(2 * sizeof(char));
        res[0] = n[0] - 1;
        res[1] = '\0';
        return res;
    }

    long long num = atoll(n);
    long long candidate = 0;
    long long minDiff = LLONG_MAX;
    char* result = (char*)malloc(2 * sizeof(char));

    char* prefix = (char*)malloc((len + 1) * sizeof(char));
    strncpy(prefix, n, (len + 1) / 2);
    prefix[(len + 1) / 2] = '\0';

    long long pre = atoll(prefix);

    for (int i = -1; i <= 1; i++) {
        long long newPre = pre + i;
        char* temp = (char*)malloc((len + 1) * sizeof(char));
        sprintf(temp, "%lld", newPre);
        char* left = temp;
        char* right = (len % 2 == 0) ? temp : temp + 1;
        char* pal = (char*)malloc((len + 1) * sizeof(char));
        strcpy(pal, left);
        strcat(pal, right);
        long long val = atoll(pal);
        long long diff = abs(val - num);
        if (diff < minDiff || (diff == minDiff && val < atoll(result))) {
            minDiff = diff;
            strcpy(result, pal);
        }
        free(temp);
        free(pal);
    }

    char* candidates[] = {"999999999", "1000000001", "99999999", "100000001", "999999", "100001", "9999", "1001", "99", "11", "9"};
    for (int i = 0; i < 11; i++) {
        long long val = atoll(candidates[i]);
        long long diff = abs(val - num);
        if (diff < minDiff || (diff == minDiff && val < atoll(result))) {
            minDiff = diff;
            strcpy(result, candidates[i]);
        }
    }

    free(prefix);
    return result;
}