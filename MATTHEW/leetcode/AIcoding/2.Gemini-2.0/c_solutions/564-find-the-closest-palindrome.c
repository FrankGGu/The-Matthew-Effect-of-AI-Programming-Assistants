#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long buildPalindrome(long long num, int evenLength) {
    char numStr[20];
    sprintf(numStr, "%lld", num);
    int len = strlen(numStr);
    char palindrome[40];
    strcpy(palindrome, numStr);
    int i, j;
    if (evenLength) {
        j = len - 1;
    } else {
        j = len - 2;
    }
    i = len;
    while (j >= 0) {
        palindrome[i++] = numStr[j--];
    }
    palindrome[i] = '\0';
    return atoll(palindrome);
}

char * nearestPalindromic(char * n) {
    long long num = atoll(n);
    int len = strlen(n);

    if (num <= 10) {
        if (num == 0) return "1";
        char *res = malloc(sizeof(char) * 2);
        sprintf(res, "%lld", num - 1);
        return res;
    }

    long long prefix = num;
    int prefixLen = (len + 1) / 2;

    char prefixStr[20];
    sprintf(prefixStr, "%lld", num);
    prefixStr[prefixLen] = '\0';
    prefix = atoll(prefixStr);

    long long candidates[3];
    candidates[0] = buildPalindrome(prefix, len % 2 == 0);
    candidates[1] = buildPalindrome(prefix - 1, len % 2 == 0);
    candidates[2] = buildPalindrome(prefix + 1, len % 2 == 0);

    long long minDiff = LLONG_MAX;
    long long result = 0;

    for (int i = 0; i < 3; i++) {
        if (candidates[i] == num) continue;
        long long diff = llabs(candidates[i] - num);
        if (diff < minDiff) {
            minDiff = diff;
            result = candidates[i];
        } else if (diff == minDiff && candidates[i] < result) {
            result = candidates[i];
        }
    }

    if (num == 10) return "9";
    if (num == 11) return "9";

    long long allNines = 1;
    for (int i = 0; i < len; ++i) {
        allNines *= 10;
    }
    allNines /= 9;

    if (llabs(allNines - num) < minDiff) {
        minDiff = llabs(allNines - num);
        result = allNines;
    } else if (llabs(allNines - num) == minDiff && allNines < result) {
        result = allNines;
    }

    long long oneZeroOne = 1;
    for (int i = 0; i < len - 1; ++i) {
        oneZeroOne *= 10;
    }
    oneZeroOne *= 11;

     if (llabs(oneZeroOne - num) < minDiff) {
        minDiff = llabs(oneZeroOne - num);
        result = oneZeroOne;
    } else if (llabs(oneZeroOne - num) == minDiff && oneZeroOne < result) {
        result = oneZeroOne;
    }

    char *res = malloc(sizeof(char) * 20);
    sprintf(res, "%lld", result);
    return res;
}