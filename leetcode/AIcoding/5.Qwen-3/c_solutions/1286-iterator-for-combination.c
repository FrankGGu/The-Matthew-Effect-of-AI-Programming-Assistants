#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** combinations;
    int size;
    int index;
} CombinationIterator;

CombinationIterator* combinationIteratorCreate(char* characters, int combinationLength) {
    int n = strlen(characters);
    int total = 1;
    for (int i = 0; i < combinationLength; i++) {
        total *= (n - i);
    }
    for (int i = 0; i < combinationLength; i++) {
        total /= (i + 1);
    }
    CombinationIterator* iter = (CombinationIterator*)malloc(sizeof(CombinationIterator));
    iter->size = total;
    iter->index = 0;
    iter->combinations = (char**)malloc(total * sizeof(char*));
    int* indices = (int*)malloc(combinationLength * sizeof(int));
    for (int i = 0; i < combinationLength; i++) {
        indices[i] = i;
    }
    int count = 0;
    while (1) {
        char* comb = (char*)malloc((combinationLength + 1) * sizeof(char));
        for (int i = 0; i < combinationLength; i++) {
            comb[i] = characters[indices[i]];
        }
        comb[combinationLength] = '\0';
        iter->combinations[count++] = comb;
        int i = combinationLength - 1;
        while (i >= 0 && indices[i] == n - combinationLength + i) {
            i--;
        }
        if (i < 0) break;
        indices[i]++;
        for (int j = i + 1; j < combinationLength; j++) {
            indices[j] = indices[j - 1] + 1;
        }
    }
    free(indices);
    return iter;
}

char* combinationIteratorNext(CombinationIterator* obj) {
    return obj->combinations[obj->index++];
}

bool combinationIteratorHasNext(CombinationIterator* obj) {
    return obj->index < obj->size;
}

void combinationIteratorFree(CombinationIterator* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->combinations[i]);
    }
    free(obj->combinations);
    free(obj);
}