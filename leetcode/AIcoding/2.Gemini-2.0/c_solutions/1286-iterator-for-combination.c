#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *characters;
    int combinationLength;
    int currentIndex;
    char *combinations;
    int totalCombinations;
} CombinationIterator;

void generateCombinations(char *characters, int combinationLength, int index, char *currentCombination, int currentLength, int start, char **combinations, int *count) {
    if (currentLength == combinationLength) {
        combinations[*count] = (char *)malloc(sizeof(char) * (combinationLength + 1));
        strcpy(combinations[*count], currentCombination);
        combinations[*count][combinationLength] = '\0';
        (*count)++;
        return;
    }

    for (int i = start; characters[i] != '\0'; i++) {
        currentCombination[currentLength] = characters[i];
        generateCombinations(characters, combinationLength, index + 1, currentCombination, currentLength + 1, i + 1, combinations, count);
    }
}

CombinationIterator* combinationIteratorCreate(char * characters, int combinationLength) {
    CombinationIterator* obj = (CombinationIterator*)malloc(sizeof(CombinationIterator));
    obj->characters = strdup(characters);
    obj->combinationLength = combinationLength;
    obj->currentIndex = 0;
    obj->totalCombinations = 0;

    int len = strlen(characters);
    long combinationsCount = 1;
    for (int i = 0; i < combinationLength; i++) {
        combinationsCount = combinationsCount * (len - i) / (i + 1);
    }

    obj->combinations = (char **)malloc(sizeof(char *) * combinationsCount);
    char *currentCombination = (char *)malloc(sizeof(char) * (combinationLength + 1));
    int count = 0;
    generateCombinations(characters, combinationLength, 0, currentCombination, 0, 0, obj->combinations, &count);
    obj->totalCombinations = count;
    free(currentCombination);

    return obj;
}

char * combinationIteratorNext(CombinationIterator* obj) {
    if (obj->currentIndex < obj->totalCombinations) {
        return obj->combinations[obj->currentIndex++];
    }
    return NULL;
}

bool combinationIteratorHasNext(CombinationIterator* obj) {
    return obj->currentIndex < obj->totalCombinations;
}

void combinationIteratorFree(CombinationIterator* obj) {
    for (int i = 0; i < obj->totalCombinations; i++) {
        free(obj->combinations[i]);
    }
    free(obj->combinations);
    free(obj->characters);
    free(obj);
}