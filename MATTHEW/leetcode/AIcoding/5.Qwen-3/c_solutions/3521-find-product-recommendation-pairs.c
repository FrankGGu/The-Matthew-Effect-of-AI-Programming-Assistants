#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int value;
} Pair;

typedef struct {
    Pair* pairs;
    int size;
} Result;

int compare(const void* a, const void* b) {
    return strcmp(((Pair*)a)->key, ((Pair*)b)->key);
}

Result* findProductRecommendationPairs(char** items, int itemsSize) {
    int* freq = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < itemsSize; i++) {
        char* item = items[i];
        for (int j = 0; j < strlen(item); j++) {
            freq[item[j] - 'a']++;
        }
    }

    Result* result = (Result*)malloc(sizeof(Result));
    result->size = 0;
    result->pairs = NULL;

    for (int i = 0; i < 26; i++) {
        if (freq[i] >= 2) {
            result->size++;
        }
    }

    if (result->size == 0) {
        return result;
    }

    result->pairs = (Pair*)malloc(result->size * sizeof(Pair));
    int index = 0;

    for (int i = 0; i < 26; i++) {
        if (freq[i] >= 2) {
            result->pairs[index].key = (char*)malloc(2 * sizeof(char));
            result->pairs[index].key[0] = i + 'a';
            result->pairs[index].key[1] = '\0';
            result->pairs[index].value = freq[i];
            index++;
        }
    }

    qsort(result->pairs, result->size, sizeof(Pair), compare);

    return result;
}