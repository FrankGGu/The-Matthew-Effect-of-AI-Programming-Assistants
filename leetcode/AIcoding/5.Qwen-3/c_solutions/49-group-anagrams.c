#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    char **anagrams;
    int size;
} AnagramGroup;

char* sortString(char* s) {
    int len = strlen(s);
    char* sorted = (char*)malloc((len + 1) * sizeof(char));
    strcpy(sorted, s);
    for (int i = 0; i < len - 1; i++) {
        for (int j = 0; j < len - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                char temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    return sorted;
}

char** createCharArray(int size) {
    char** arr = (char**)malloc(size * sizeof(char*));
    for (int i = 0; i < size; i++) {
        arr[i] = NULL;
    }
    return arr;
}

char*** groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    AnagramGroup* groups = (AnagramGroup*)malloc(strsSize * sizeof(AnagramGroup));
    int groupCount = 0;

    for (int i = 0; i < strsSize; i++) {
        char* sorted = sortString(strs[i]);
        int found = 0;
        for (int j = 0; j < groupCount; j++) {
            if (strcmp(groups[j].key, sorted) == 0) {
                groups[j].anagrams[groups[j].size++] = strs[i];
                found = 1;
                break;
            }
        }
        if (!found) {
            groups[groupCount].key = sorted;
            groups[groupCount].anagrams = createCharArray(strsSize);
            groups[groupCount].anagrams[0] = strs[i];
            groups[groupCount].size = 1;
            groupCount++;
        }
    }

    *returnSize = groupCount;
    *returnColumnSizes = (int*)malloc(groupCount * sizeof(int));
    char*** result = (char***)malloc(groupCount * sizeof(char*));

    for (int i = 0; i < groupCount; i++) {
        (*returnColumnSizes)[i] = groups[i].size;
        result[i] = groups[i].anagrams;
    }

    for (int i = 0; i < groupCount; i++) {
        free(groups[i].key);
    }

    free(groups);
    return result;
}