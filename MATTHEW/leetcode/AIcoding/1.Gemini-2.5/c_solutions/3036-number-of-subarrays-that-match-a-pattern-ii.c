#include <stdlib.h>

int findMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    if (numsSize < 2 || patternSize == 0) {
        return 0;
    }

    int textArrSize = numsSize - 1;
    if (textArrSize < patternSize) {
        return 0;
    }

    int* textArr = (int*)malloc(sizeof(int) * textArrSize);
    if (textArr == NULL) {
        return 0;
    }

    for (int k = 0; k < textArrSize; ++k) {
        if (nums[k+1] > nums[k]) {
            textArr[k] = 1;
        } else if (nums[k+1] < nums[k]) {
            textArr[k] = -1;
        } else {
            textArr[k] = 0;
        }
    }

    int* lps = (int*)malloc(sizeof(int) * patternSize);
    if (lps == NULL) {
        free(textArr);
        return 0;
    }

    lps[0] = 0;
    int length = 0;
    int i = 1;

    while (i < patternSize) {
        if (pattern[i] == pattern[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length != 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    int count = 0;
    int j = 0;
    int k = 0;

    while (k < textArrSize) {
        if (pattern[j] == textArr[k]) {
            j++;
            k++;
        }

        if (j == patternSize) {
            count++;
            j = lps[j - 1];
        } else if (k < textArrSize && pattern[j] != textArr[k]) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                k++;
            }
        }
    }

    free(textArr);
    free(lps);

    return count;
}