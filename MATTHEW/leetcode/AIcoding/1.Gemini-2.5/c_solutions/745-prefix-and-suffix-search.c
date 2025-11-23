#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct HashNode {
    char* key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct HashMap {
    int capacity;
    int size;
    HashNode** buckets;
} HashMap;

unsigned int hash(const char* str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

HashNode* createNode(const char* key, int value) {
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    if (newNode == NULL) return NULL;
    newNode->key = strdup(key);
    if (newNode->key == NULL) {
        free(newNode);
        return NULL;
    }
    newNode->value = value;
    newNode->next = NULL;
    return newNode;
}

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    if (map == NULL) return NULL;
    map->capacity = capacity;
    map->size = 0;
    map->buckets = (HashNode**)calloc(capacity, sizeof(HashNode*));
    if (map->buckets == NULL) {
        free(map);
        return NULL;
    }
    return map;
}

void hashMapPut(HashMap* map, const char* key, int value) {
    unsigned int index = hash(key) % map->capacity;
    HashNode* current = map->buckets[index];

    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            if (value > current->value) {
                current->value = value;
            }
            return;
        }
        current = current->next;
    }

    HashNode* newNode = createNode(key, value);
    if (newNode == NULL) return;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
    map->size++;
}

int hashMapGet(HashMap* map, const char* key) {
    unsigned int index = hash(key) % map->capacity;
    HashNode* current = map->buckets[index];

    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }
    return -1;
}

void freeHashMap(HashMap* map) {
    if (map == NULL) return;
    for (int i = 0; i < map->capacity; i++) {
        HashNode* current = map->buckets[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp->key);
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

typedef struct {
    HashMap* map;
} WordFilter;

WordFilter* wordFilterCreate(char** words, int wordsSize) {
    WordFilter* obj = (WordFilter*)malloc(sizeof(WordFilter));
    if (obj == NULL) return NULL;

    int mapCapacity = 1500007; 
    obj->map = createHashMap(mapCapacity);
    if (obj->map == NULL) {
        free(obj);
        return NULL;
    }

    char* combined_key_buffer = (char*)malloc(2 * 10 + 1 + 1);
    if (combined_key_buffer == NULL) {
        freeHashMap(obj->map);
        free(obj);
        return NULL;
    }

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int word_len = strlen(word);

        for (int p_len = 0; p_len <= word_len; p_len++) {
            for (int s_start_idx = 0; s_start_idx <= word_len; s_start_idx++) {
                int current_len = 0;
                if (p_len > 0) {
                    strncpy(combined_key_buffer, word, p_len);
                    current_len += p_len;
                }
                combined_key_buffer[current_len] = '#';
                current_len++;

                if (s_start_idx < word_len) {
                    strncpy(combined_key_buffer + current_len, word + s_start_idx, word_len - s_start_idx);
                    current_len += (word_len - s_start_idx);
                }
                combined_key_buffer[current_len] = '\0';

                hashMapPut(obj->map, combined_key_buffer, i);
            }
        }
    }

    free(combined_key_buffer);
    return obj;
}

int wordFilterF(WordFilter* obj, char* pref, char* suff) {
    if (obj == NULL || obj->map == NULL) return -1;

    char combined_query_buffer[22]; 
    snprintf(combined_query_buffer, sizeof(combined_query_buffer), "%s#%s", pref, suff);

    return hashMapGet(obj->map, combined_query_buffer);
}

void wordFilterFree(WordFilter* obj) {
    if (obj == NULL) return;
    freeHashMap(obj->map);
    free(obj);
}