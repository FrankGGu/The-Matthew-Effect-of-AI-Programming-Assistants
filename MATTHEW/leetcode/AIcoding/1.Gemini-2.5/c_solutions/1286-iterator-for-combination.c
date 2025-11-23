#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char *characters;
    int char_len;
    int combinationLength;
    char *current_combination; // Stores the combination to be returned by the next call to next()
    int *indices;              // Stores indices of characters for current_combination
    bool has_next_flag;        // True if there is a valid combination in current_combination
} CombinationIterator;

CombinationIterator* combinationIteratorCreate(char *characters, int combinationLength) {
    CombinationIterator *obj = (CombinationIterator *)malloc(sizeof(CombinationIterator));
    obj->characters = characters; 
    obj->char_len = strlen(characters);
    obj->combinationLength = combinationLength;

    obj->current_combination = (char *)malloc(sizeof(char) * (combinationLength + 1));
    obj->indices = (int *)malloc(sizeof(int) * combinationLength);

    // Initialize indices to the first combination (0, 1, ..., combinationLength-1)
    for (int i = 0; i < combinationLength; i++) {
        obj->indices[i] = i;
        obj->current_combination[i] = characters[i];
    }
    obj->current_combination[combinationLength] = '\0';

    obj->has_next_flag = true; // Initially, there is always at least one combination

    return obj;
}

char* combinationIteratorNext(CombinationIterator* obj) {
    // This function should return the combination currently stored in current_combination,
    // and then prepare the next one.
    char *result = obj->current_combination;

    // Prepare for the next combination
    int i = obj->combinationLength - 1;

    // Find the rightmost index that can be incremented
    // The maximum value for indices[k] is obj->char_len - (obj->combinationLength - k)
    // For example, if char_len=5, combinationLength=3
    // k=2 (last index): max value is 5 - (3-2) = 4
    // k=1: max value is 5 - (3-1) = 3
    // k=0: max value is 5 - (3-0) = 2
    while (i >= 0 && obj->indices[i] == obj->char_len - (obj->combinationLength - i)) {
        i--;
    }

    if (i < 0) {
        // No more combinations after the one just returned
        obj->has_next_flag = false;
    } else {
        // Increment the found index
        obj->indices[i]++;
        // Update subsequent indices to be consecutive
        for (int j = i + 1; j < obj->combinationLength; j++) {
            obj->indices[j] = obj->indices[j-1] + 1;
        }

        // Update current_combination based on new indices
        for (int k = 0; k < obj->combinationLength; k++) {
            obj->current_combination[k] = obj->characters[obj->indices[k]];
        }
        obj->current_combination[obj->combinationLength] = '\0';
    }

    return result;
}

bool combinationIteratorHasNext(CombinationIterator* obj) {
    return obj->has_next_flag;
}

void combinationIteratorFree(CombinationIterator* obj) {
    free(obj->current_combination);
    free(obj->indices);
    free(obj);
}