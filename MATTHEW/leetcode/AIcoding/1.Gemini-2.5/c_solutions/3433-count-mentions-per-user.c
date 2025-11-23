#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#define HASH_CAPACITY 10007 // A prime number for better distribution

typedef struct HashNode {
    char* key;
    int value; // Stores the index of the user in the original 'users' array
    struct HashNode* next;
} HashNode;

typedef struct HashMap {
    HashNode** table;
    int size; // Number of elements currently in the map
    int capacity; // Total number of buckets
} HashMap;

unsigned int hash(const char* str) {
    unsigned int hash_val = 0;
    while (*str) {
        hash_val = (hash_val << 5) + *str++;
    }
    return hash_val % HASH_CAPACITY;
}

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = HASH_CAPACITY;
    map->size = 0;
    map->table = (HashNode**)calloc(map->capacity, sizeof(HashNode*));
    return map;
}

void hashMapInsert(HashMap* map, const char* key, int value) {
    unsigned int index = hash(key);
    HashNode* node = map->table[index];

    // Check if key already exists
    while (node != NULL) {
        if (strcmp(node->key, key) == 0) {
            node->value = value; // Update existing value
            return;
        }
        node = node->next;
    }

    // Key does not exist, create a new node
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = strdup(key); // Duplicate key string
    newNode->value = value;
    newNode->next = map->table[index]; // Prepend to the list
    map->table[index] = newNode;
    map->size++;
}

int hashMapGet(HashMap* map, const char* key, int* outValue) {
    unsigned int index = hash(key);
    HashNode* node = map->table[index];

    while (node != NULL) {
        if (strcmp(node->key, key) == 0) {
            *outValue = node->value;
            return 1; // Key found
        }
        node = node->next;
    }
    return 0; // Key not found
}

void freeHashMap(HashMap* map) {
    if (!map) return;
    for (int i = 0; i < map->capacity; i++) {
        HashNode* node = map->table[i];
        while (node != NULL) {
            HashNode* temp = node;
            node = node->next;
            free(temp->key); // Free duplicated key string
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

char*** countMentionsPerUser(char** users, int usersSize, char** tweets, int tweetsSize, int* returnSize, int** returnCounts) {
    if (users == NULL || usersSize == 0) {
        *returnSize = 0;
        *returnCounts = NULL;
        return NULL;
    }

    HashMap* userToIndexMap = createHashMap();
    for (int i = 0; i < usersSize; i++) {
        hashMapInsert(userToIndexMap, users[i], i);
    }

    int* mentionCounts = (int*)calloc(usersSize, sizeof(int));

    for (int i = 0; i < tweetsSize; i++) {
        const char* tweet = tweets[i];
        if (tweet == NULL) continue;

        int tweetLen = strlen(tweet);

        for (int j = 0; j < tweetLen; j++) {
            if (tweet[j] == '@') {
                int k = j + 1;
                while (k < tweetLen && (isalnum(tweet[k]) || tweet[k] == '_')) {
                    k++;
                }

                if (k > j + 1) {
                    int mentionLen = k - (j + 1);
                    char* mentionedUsername = (char*)malloc(mentionLen + 1);
                    strncpy(mentionedUsername, tweet + j + 1, mentionLen);
                    mentionedUsername[mentionLen] = '\0';

                    int userIdx;
                    if (hashMapGet(userToIndexMap, mentionedUsername, &userIdx)) {
                        mentionCounts[userIdx]++;
                    }
                    free(mentionedUsername);
                }
                j = k - 1; 
            }
        }
    }

    *returnSize = usersSize;
    *returnCounts = mentionCounts;

    char** resultUsersArray = (char**)malloc(usersSize * sizeof(char*));
    for (int i = 0; i < usersSize; i++) {
        resultUsersArray[i] = strdup(users[i]);
    }

    char*** finalReturn = (char***)malloc(sizeof(char**));
    *finalReturn = resultUsersArray;

    freeHashMap(userToIndexMap);

    return finalReturn;
}