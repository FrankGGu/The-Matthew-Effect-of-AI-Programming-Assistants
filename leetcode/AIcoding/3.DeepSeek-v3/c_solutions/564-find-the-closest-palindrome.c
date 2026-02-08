#include <stdlib.h>
#include <string.h>
#include <limits.h>

long long createPalindrome(long long half, int isOdd) {
    long long palin = half;
    if (isOdd) half /= 10;
    while (half > 0) {
        palin = palin * 10 + half % 10;
        half /= 10;
    }
    return palin;
}

char* nearestPalindromic(char* n) {
    int len = strlen(n);
    long long num = atoll(n);

    if (num <= 10) {
        char* result = malloc(2);
        sprintf(result, "%lld", num - 1);
        return result;
    }

    if (num == 11) {
        char* result = malloc(2);
        strcpy(result, "9");
        return result;
    }

    long long half = atoll(strndup(n, (len + 1) / 2));

    long long candidates[5];
    int candidateCount = 0;

    candidates[candidateCount++] = createPalindrome(half, len % 2);
    candidates[candidateCount++] = createPalindrome(half + 1, len % 2);
    candidates[candidateCount++] = createPalindrome(half - 1, len % 2);
    candidates[candidateCount++] = (long long)pow(10, len - 1) - 1;
    candidates[candidateCount++] = (long long)pow(10, len) + 1;

    long long minDiff = LLONG_MAX;
    long long result = 0;

    for (int i = 0; i < candidateCount; i++) {
        if (candidates[i] == num) continue;

        long long diff = llabs(candidates[i] - num);
        if (diff < minDiff || (diff == minDiff && candidates[i] < result)) {
            minDiff = diff;
            result = candidates[i];
        }
    }

    char* resStr = malloc(20);
    sprintf(resStr, "%lld", result);
    return resStr;
}