#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char*** partition(char* s, int* returnSize) {
    int n = strlen(s);
    char*** result = (char***)malloc(sizeof(char**) * 1000); // Assume max 1000 partitions
    int* resultSize = (int*)malloc(sizeof(int));
    *resultSize = 0;

    char** current = (char**)malloc(n * sizeof(char*));

    int isPalindrome(int left, int right) {
        while (left < right) {
            if (s[left] != s[right]) return 0;
            left++;
            right--;
        }
        return 1;
    }

    void backtrack(int start) {
        if (start == n) {
            char** temp = (char**)malloc((*resultSize + 1) * sizeof(char*));
            for (int i = 0; i < *resultSize; i++) {
                temp[i] = result[i][0];
            }
            temp[*resultSize] = NULL;
            result[*resultSize] = (char**)malloc(((*resultSize) + 1) * sizeof(char*));
            for (int i = 0; i < *resultSize; i++) {
                result[*resultSize][i] = strdup(temp[i]);
            }
            result[*resultSize][*resultSize] = NULL;
            (*resultSize)++;
            free(temp);
            return;
        }

        for (int end = start; end < n; end++) {
            if (isPalindrome(start, end)) {
                current[*resultSize] = (char*)malloc(end - start + 2);
                strncpy(current[*resultSize], s + start, end - start + 1);
                current[*resultSize][end - start + 1] = '\0';
                backtrack(end + 1);
                free(current[*resultSize]);
            }
        }
    }

    backtrack(0);

    *returnSize = *resultSize;
    return result;
}