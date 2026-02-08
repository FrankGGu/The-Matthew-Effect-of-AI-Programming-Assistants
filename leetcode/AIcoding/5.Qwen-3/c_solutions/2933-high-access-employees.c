#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int time;
} AccessRecord;

typedef struct {
    char* name;
    int count;
} NameCount;

int compare(const void* a, const void* b) {
    AccessRecord* x = (AccessRecord*)a;
    AccessRecord* y = (AccessRecord*)b;
    return x->time - y->time;
}

int compareNameCount(const void* a, const void* b) {
    NameCount* x = (NameCount*)a;
    NameCount* y = (NameCount*)b;
    return strcmp(x->name, y->name);
}

char** highAccessEmployees(char*** accessTimes, int accessTimesSize, int* accessTimesColSize, int* returnSize) {
    AccessRecord* records = (AccessRecord*)malloc(accessTimesSize * sizeof(AccessRecord));
    for (int i = 0; i < accessTimesSize; i++) {
        records[i].name = accessTimes[i][0];
        records[i].time = atoi(accessTimes[i][1]);
    }

    qsort(records, accessTimesSize, sizeof(AccessRecord), compare);

    NameCount* nameCounts = (NameCount*)malloc(accessTimesSize * sizeof(NameCount));
    int nameCountSize = 0;

    for (int i = 0; i < accessTimesSize; i++) {
        if (i > 0 && strcmp(records[i].name, records[i - 1].name) == 0) {
            nameCounts[nameCountSize - 1].count++;
        } else {
            nameCounts[nameCountSize].name = records[i].name;
            nameCounts[nameCountSize].count = 1;
            nameCountSize++;
        }
    }

    char** result = (char**)malloc(nameCountSize * sizeof(char*));
    int resSize = 0;

    for (int i = 0; i < nameCountSize; i++) {
        if (nameCounts[i].count >= 3) {
            result[resSize++] = nameCounts[i].name;
        }
    }

    free(nameCounts);
    free(records);

    *returnSize = resSize;
    return result;
}