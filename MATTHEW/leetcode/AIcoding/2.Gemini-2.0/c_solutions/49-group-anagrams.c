#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STR_LEN 100
#define MAX_NUM_STRS 10000

typedef struct {
    char str[MAX_STR_LEN + 1];
    char sorted_str[MAX_STR_LEN + 1];
    int group_index;
} StringInfo;

int compare_strings(const void *a, const void *b) {
    return strcmp(((StringInfo*)a)->sorted_str, ((StringInfo*)b)->sorted_str);
}

char *** groupAnagrams(char ** strs, int strsSize, int* returnSize, int** returnColumnSizes){
    StringInfo string_info[strsSize];
    for (int i = 0; i < strsSize; i++) {
        strcpy(string_info[i].str, strs[i]);
        strcpy(string_info[i].sorted_str, strs[i]);
        int len = strlen(string_info[i].sorted_str);
        qsort(string_info[i].sorted_str, len, sizeof(char), (int (*)(const void *, const void *))strcmp);
        string_info[i].group_index = -1;
    }

    qsort(string_info, strsSize, sizeof(StringInfo), compare_strings);

    int group_count = 0;
    for (int i = 0; i < strsSize; i++) {
        if (string_info[i].group_index == -1) {
            string_info[i].group_index = group_count++;
            for (int j = i + 1; j < strsSize; j++) {
                if (strcmp(string_info[i].sorted_str, string_info[j].sorted_str) == 0) {
                    string_info[j].group_index = string_info[i].group_index;
                }
            }
        }
    }

    char ***result = (char ***)malloc(group_count * sizeof(char **));
    *returnColumnSizes = (int *)malloc(group_count * sizeof(int));
    for (int i = 0; i < group_count; i++) {
        (*returnColumnSizes)[i] = 0;
    }

    for (int i = 0; i < strsSize; i++) {
        (*returnColumnSizes)[string_info[i].group_index]++;
    }

    for (int i = 0; i < group_count; i++) {
        result[i] = (char **)malloc((*returnColumnSizes)[i] * sizeof(char *));
        (*returnColumnSizes)[i] = 0;
    }

    for (int i = 0; i < strsSize; i++) {
        int group_index = string_info[i].group_index;
        int col_index = (*returnColumnSizes)[group_index];
        result[group_index][col_index] = string_info[i].str;
        (*returnColumnSizes)[group_index]++;
    }

    *returnSize = group_count;
    return result;
}