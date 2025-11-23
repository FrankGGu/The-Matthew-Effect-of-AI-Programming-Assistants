#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestPalindromic(char * number){
    int counts[10] = {0};
    int n = strlen(number);
    for (int i = 0; i < n; i++) {
        counts[number[i] - '0']++;
    }

    char *result = (char *)malloc((n + 1) * sizeof(char));
    int left = 0;
    int right = 0;
    for (int i = 9; i >= 0; i--) {
        int numPairs = counts[i] / 2;
        for (int j = 0; j < numPairs; j++) {
            result[left++] = i + '0';
        }
    }
    result[left] = '\0';
    right = left - 1;

    int singleDigit = -1;
    for (int i = 9; i >= 0; i--) {
        if (counts[i] % 2 == 1) {
            singleDigit = i;
            break;
        }
    }

    if (left == 0 && singleDigit == -1) {
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    if (left > 0 && result[0] == '0') {
        int i = 0;
        while (i < left && result[i] == '0') {
            i++;
        }
        if (i == left) {
            if (singleDigit != -1) {
                result[0] = singleDigit + '0';
                result[1] = '\0';
            } else {
                result[0] = '0';
                result[1] = '\0';
            }
            return result;
        }
    }

    int len = left + (singleDigit != -1 ? 1 : 0) + left;
    char *finalResult = (char *)malloc((len + 1) * sizeof(char));

    int k = 0;
    for (int i = 0; i < left; i++) {
        finalResult[k++] = result[i];
    }

    if (singleDigit != -1) {
        finalResult[k++] = singleDigit + '0';
    }

    for (int i = right; i >= 0; i--) {
        finalResult[k++] = result[i];
    }

    finalResult[k] = '\0';
    free(result);
    return finalResult;
}