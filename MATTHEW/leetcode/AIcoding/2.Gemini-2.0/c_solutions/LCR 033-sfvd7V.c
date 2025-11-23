#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STR_LEN 100
#define MAX_NUM_STRS 10000

char* str_sort(char* s) {
    int len = strlen(s);
    char* sorted_s = (char*)malloc((len + 1) * sizeof(char));
    strcpy(sorted_s, s);
    for (int i = 0; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
            if (sorted_s[i] > sorted_s[j]) {
                char temp = sorted_s[i];
                sorted_s[i] = sorted_s[j];
                sorted_s[j] = temp;
            }
        }
    }
    sorted_s[len] = '\0';
    return sorted_s;
}

char *** groupAnagrams(char ** strs, int strsSize, int* returnSize, int** returnColumnSizes){
    char *** result = (char ***)malloc(strsSize * sizeof(char **));
    *returnColumnSizes = (int *)malloc(strsSize * sizeof(int));
    *returnSize = 0;

    int * anagram_group_indices = (int *)malloc(strsSize * sizeof(int));
    for (int i = 0; i < strsSize; i++) {
        anagram_group_indices[i] = -1;
    }

    for (int i = 0; i < strsSize; i++) {
        if (anagram_group_indices[i] == -1) {
            anagram_group_indices[i] = *returnSize;
            (*returnColumnSizes)[*returnSize] = 0;
            result[*returnSize] = (char **)malloc(strsSize * sizeof(char *));
            result[*returnSize][(*returnColumnSizes)[*returnSize]++] = strs[i];

            for (int j = i + 1; j < strsSize; j++) {
                if (anagram_group_indices[j] == -1) {
                    char * sorted_i = str_sort(strs[i]);
                    char * sorted_j = str_sort(strs[j]);
                    if (strcmp(sorted_i, sorted_j) == 0) {
                        anagram_group_indices[j] = *returnSize;
                        result[*returnSize][(*returnColumnSizes)[*returnSize]++] = strs[j];
                    }
                    free(sorted_i);
                    free(sorted_j);
                }
            }
            (*returnSize)++;
        }
    }
    free(anagram_group_indices);
    return result;
}