#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} DictNode;

typedef struct {
    DictNode **table;
    int size;
    int capacity;
} MagicDict;

MagicDict* magicDictCreate() {
    MagicDict *dict = (MagicDict*)malloc(sizeof(MagicDict));
    dict->size = 0;
    dict->capacity = 16;
    dict->table = (DictNode**)calloc(dict->capacity, sizeof(DictNode*));
    return dict;
}

void magicDictBuildDict(MagicDict* obj, char** dictionary, int dictionarySize) {
    for (int i = 0; i < dictionarySize; i++) {
        char *key = strdup(dictionary[i]);
        int index = abs(strhash(key)) % obj->capacity;
        while (obj->table[index] != NULL) {
            if (strcmp(obj->table[index]->key, key) == 0) {
                break;
            }
            index = (index + 1) % obj->capacity;
        }
        if (obj->table[index] == NULL) {
            obj->table[index] = (DictNode*)malloc(sizeof(DictNode));
            obj->table[index]->key = key;
            obj->table[index]->value = 1;
            obj->size++;
        }
    }
}

int strhash(char *s) {
    int hash = 0;
    while (*s) {
        hash = hash * 31 + *s++;
    }
    return hash;
}

int magicDictSearch(MagicDict* obj, char* word) {
    int index = abs(strhash(word)) % obj->capacity;
    for (int i = 0; i < obj->capacity; i++) {
        if (obj->table[index] != NULL && strcmp(obj->table[index]->key, word) == 0) {
            return 1;
        }
        index = (index + 1) % obj->capacity;
    }
    return 0;
}

void magicDictFree(MagicDict* obj) {
    for (int i = 0; i < obj->capacity; i++) {
        if (obj->table[i] != NULL) {
            free(obj->table[i]->key);
            free(obj->table[i]);
        }
    }
    free(obj->table);
    free(obj);
}