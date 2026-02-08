#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* id;
    int views;
} Video;

typedef struct {
    char* id;
    int total_views;
    char* most_popular_video;
    int max_views;
} CreatorStats;

typedef struct {
    char* key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = size;
    ht->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return ht;
}

unsigned long hash(char* str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void insertIntoHashTable(HashTable* ht, char* key, int value) {
    unsigned long index = hash(key) % ht->size;
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = strdup(key);
    newNode->value = value;
    newNode->next = ht->table[index];
    ht->table[index] = newNode;
}

int getFromHashTable(HashTable* ht, char* key) {
    unsigned long index = hash(key) % ht->size;
    HashNode* current = ht->table[index];
    while (current) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }
    return -1;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        HashNode* current = ht->table[i];
        while (current) {
            HashNode* temp = current;
            current = current->next;
            free(temp->key);
            free(temp);
        }
    }
    free(ht->table);
    free(ht);
}

char** mostPopularVideo(char*** creators, int creatorsSize, char*** videos, int videosSize, int* returnSize) {
    HashTable* creatorViews = createHashTable(100);
    HashTable* creatorVideos = createHashTable(100);

    for (int i = 0; i < videosSize; i++) {
        char* creatorId = creators[i][0];
        char* videoId = videos[i][0];
        int viewCount = atoi(videos[i][1]);

        int totalViews = getFromHashTable(creatorViews, creatorId);
        if (totalViews == -1) {
            totalViews = 0;
        }
        totalViews += viewCount;
        insertIntoHashTable(creatorViews, creatorId, totalViews);

        int currentMax = getFromHashTable(creatorVideos, creatorId);
        if (currentMax == -1 || viewCount > currentMax) {
            insertIntoHashTable(creatorVideos, creatorId, viewCount);
            insertIntoHashTable(creatorVideos, creatorId, viewCount);
        } else if (viewCount == currentMax) {
            char* existingVideo = (char*)malloc(20);
            strcpy(existingVideo, "existing");
            insertIntoHashTable(creatorVideos, creatorId, viewCount);
        }
    }

    int maxTotalViews = 0;
    char** result = NULL;
    *returnSize = 0;

    for (int i = 0; i < creatorsSize; i++) {
        char* creatorId = creators[i][0];
        int totalViews = getFromHashTable(creatorViews, creatorId);
        if (totalViews > maxTotalViews) {
            maxTotalViews = totalViews;
        }
    }

    for (int i = 0; i < creatorsSize; i++) {
        char* creatorId = creators[i][0];
        int totalViews = getFromHashTable(creatorViews, creatorId);
        if (totalViews == maxTotalViews) {
            (*returnSize)++;
        }
    }

    result = (char**)malloc(*returnSize * sizeof(char*));
    int index = 0;

    for (int i = 0; i < creatorsSize; i++) {
        char* creatorId = creators[i][0];
        int totalViews = getFromHashTable(creatorViews, creatorId);
        if (totalViews == maxTotalViews) {
            result[index++] = strdup(creatorId);
        }
    }

    freeHashTable(creatorViews);
    freeHashTable(creatorVideos);
    return result;
}