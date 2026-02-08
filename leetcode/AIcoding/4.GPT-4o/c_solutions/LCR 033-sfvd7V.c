#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STR_LEN 100
#define HASH_SIZE 10000

typedef struct {
    char **group;
    int count;
} Group;

typedef struct {
    Group *groups;
    int size;
} Result;

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % HASH_SIZE;
}

int compare(const void *a, const void *b) {
    return strcmp(*(char **)a, *(char **)b);
}

Result* groupAnagrams(char ** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    char *hashTable[HASH_SIZE][MAX_STR_LEN];
    int hashCount[HASH_SIZE] = {0};
    int groupCount = 0;

    for (int i = 0; i < strsSize; i++) {
        char *sortedStr = strdup(strs[i]);
        qsort(sortedStr, strlen(sortedStr), sizeof(char), compare);
        unsigned long index = hash(sortedStr);

        if (hashCount[index] == 0) {
            groupCount++;
        }

        strcpy(hashTable[index][hashCount[index]], strs[i]);
        hashCount[index]++;
        free(sortedStr);
    }

    Result *result = (Result *)malloc(sizeof(Result));
    result->groups = (Group *)malloc(sizeof(Group) * groupCount);
    result->size = groupCount;

    int groupIndex = 0;
    for (int i = 0; i < HASH_SIZE; i++) {
        if (hashCount[i] > 0) {
            result->groups[groupIndex].count = hashCount[i];
            result->groups[groupIndex].group = (char **)malloc(sizeof(char *) * hashCount[i]);
            for (int j = 0; j < hashCount[i]; j++) {
                result->groups[groupIndex].group[j] = strdup(hashTable[i][j]);
            }
            groupIndex++;
        }
    }

    *returnSize = groupCount;
    *returnColumnSizes = (int *)malloc(sizeof(int) * groupCount);
    for (int i = 0; i < groupCount; i++) {
        (*returnColumnSizes)[i] = result->groups[i].count;
    }

    return result;
}