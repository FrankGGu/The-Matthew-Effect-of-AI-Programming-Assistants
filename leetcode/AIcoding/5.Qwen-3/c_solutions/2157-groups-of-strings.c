#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int count;
} Pair;

int compare(const void* a, const void* b) {
    return strcmp(((Pair*)a)->key, ((Pair*)b)->key);
}

int getGroupCount(char** strings, int stringsSize) {
    Pair* pairs = (Pair*)malloc(stringsSize * sizeof(Pair));
    for (int i = 0; i < stringsSize; i++) {
        pairs[i].key = strdup(strings[i]);
        pairs[i].count = 1;
    }

    qsort(pairs, stringsSize, sizeof(Pair), compare);

    int groupCount = 0;
    for (int i = 0; i < stringsSize; i++) {
        groupCount++;
        for (int j = i + 1; j < stringsSize; j++) {
            if (strcmp(pairs[i].key, pairs[j].key) == 0) {
                pairs[i].count += pairs[j].count;
                i++;
            }
        }
    }

    for (int i = 0; i < stringsSize; i++) {
        free(pairs[i].key);
    }
    free(pairs);

    return groupCount;
}