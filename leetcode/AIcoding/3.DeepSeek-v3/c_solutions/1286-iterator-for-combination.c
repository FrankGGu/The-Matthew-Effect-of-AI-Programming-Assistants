typedef struct {
    char* characters;
    int length;
    int combinationLength;
    int* indices;
    bool hasNext;
} CombinationIterator;

CombinationIterator* combinationIteratorCreate(char* characters, int combinationLength) {
    CombinationIterator* obj = (CombinationIterator*)malloc(sizeof(CombinationIterator));
    obj->characters = characters;
    obj->length = strlen(characters);
    obj->combinationLength = combinationLength;
    obj->indices = (int*)malloc(combinationLength * sizeof(int));
    obj->hasNext = true;

    for (int i = 0; i < combinationLength; i++) {
        obj->indices[i] = i;
    }

    return obj;
}

char* combinationIteratorNext(CombinationIterator* obj) {
    char* result = (char*)malloc((obj->combinationLength + 1) * sizeof(char));
    for (int i = 0; i < obj->combinationLength; i++) {
        result[i] = obj->characters[obj->indices[i]];
    }
    result[obj->combinationLength] = '\0';

    int i = obj->combinationLength - 1;
    while (i >= 0 && obj->indices[i] == obj->length - obj->combinationLength + i) {
        i--;
    }

    if (i >= 0) {
        obj->indices[i]++;
        for (int j = i + 1; j < obj->combinationLength; j++) {
            obj->indices[j] = obj->indices[j - 1] + 1;
        }
    } else {
        obj->hasNext = false;
    }

    return result;
}

bool combinationIteratorHasNext(CombinationIterator* obj) {
    return obj->hasNext;
}

void combinationIteratorFree(CombinationIterator* obj) {
    free(obj->indices);
    free(obj);
}