#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** dict;
    int size;
    int capacity;
} MagicDictionary;

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* obj = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    obj->dict = NULL;
    obj->size = 0;
    obj->capacity = 0;
    return obj;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char** dictionary, int dictionarySize) {
    obj->dict = (char**)malloc(sizeof(char*) * dictionarySize);
    obj->size = dictionarySize;
    obj->capacity = dictionarySize;
    for (int i = 0; i < dictionarySize; i++) {
        obj->dict[i] = (char*)malloc(sizeof(char) * (strlen(dictionary[i]) + 1));
        strcpy(obj->dict[i], dictionary[i]);
    }
}

bool magicDictionarySearch(MagicDictionary* obj, char* searchWord) {
    int len = strlen(searchWord);
    for (int i = 0; i < obj->size; i++) {
        if (strlen(obj->dict[i]) == len) {
            int diff = 0;
            for (int j = 0; j < len; j++) {
                if (obj->dict[i][j] != searchWord[j]) {
                    diff++;
                }
            }
            if (diff == 1) {
                return true;
            }
        }
    }
    return false;
}

void magicDictionaryFree(MagicDictionary* obj) {
    if (obj) {
        if (obj->dict) {
            for (int i = 0; i < obj->size; i++) {
                free(obj->dict[i]);
            }
            free(obj->dict);
        }
        free(obj);
    }
}