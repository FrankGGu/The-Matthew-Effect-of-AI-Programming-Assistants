#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* constructPalindrome(char* s, int* isPossible) {
    int count[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int mid = -1;
    int oddCount = 0;

    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            oddCount++;
            mid = i;
        }
    }

    if (oddCount > 1) {
        *isPossible = 0;
        free(result);
        return NULL;
    }

    *isPossible = 1;
    int left = 0;
    int right = len - 1;

    for (int i = 0; i < 26; i++) {
        while (count[i] > 1) {
            result[left++] = i + 'a';
            result[right--] = i + 'a';
            count[i] -= 2;
        }
    }

    if (mid != -1) {
        result[left] = mid + 'a';
    }

    result[len] = '\0';
    return result;
}

char* smallestPaliRearrangement(char* s) {
    int isPossible = 0;
    char* result = constructPalindrome(s, &isPossible);
    return result;
}