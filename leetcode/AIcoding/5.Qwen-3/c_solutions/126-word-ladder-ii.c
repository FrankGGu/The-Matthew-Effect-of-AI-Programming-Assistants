#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    char** words;
    int size;
} WordList;

typedef struct {
    char* word;
    int level;
    char** path;
    int pathSize;
} Node;

typedef struct {
    char* key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashTable;

HashTable* createHashTable(int capacity) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = capacity;
    ht->table = (HashNode**)calloc(capacity, sizeof(HashNode*));
    return ht;
}

unsigned long hash(char* str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash;
}

void insertIntoHashTable(HashTable* ht, char* key, int value) {
    unsigned long index = hash(key) % ht->size;
    HashNode* node = (HashNode*)malloc(sizeof(HashNode));
    node->key = strdup(key);
    node->value = value;
    node->next = ht->table[index];
    ht->table[index] = node;
}

int getFromHashTable(HashTable* ht, char* key) {
    unsigned long index = hash(key) % ht->size;
    HashNode* current = ht->table[index];
    while (current) {
        if (strcmp(current->key, key) == 0)
            return current->value;
        current = current->next;
    }
    return -1;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        HashNode* current = ht->table[i];
        while (current) {
            HashNode* next = current->next;
            free(current->key);
            free(current);
            current = next;
        }
    }
    free(ht->table);
    free(ht);
}

char** findLadders(char** beginWord, char** endWord, int n, char*** wordList, int* returnSize) {
    int wordListSize = n;
    char** wordListCopy = (char**)malloc((wordListSize + 1) * sizeof(char*));
    for (int i = 0; i < wordListSize; i++)
        wordListCopy[i] = strdup(wordList[i][0]);
    wordListCopy[wordListSize] = NULL;

    HashTable* dict = createHashTable(wordListSize * 2);
    for (int i = 0; i < wordListSize; i++)
        insertIntoHashTable(dict, wordListCopy[i], 1);

    int endWordIndex = -1;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordListCopy[i], *endWord) == 0) {
            endWordIndex = i;
            break;
        }
    }

    if (endWordIndex == -1) {
        *returnSize = 0;
        return NULL;
    }

    HashTable* visited = createHashTable(wordListSize * 2);
    insertIntoHashTable(visited, *beginWord, 1);

    Node* queue[10000];
    int front = 0, rear = 0;
    Node* start = (Node*)malloc(sizeof(Node));
    start->word = strdup(*beginWord);
    start->level = 0;
    start->path = (char**)malloc(sizeof(char*));
    start->path[0] = strdup(*beginWord);
    start->pathSize = 1;
    queue[rear++] = start;

    int found = 0;
    char*** result = (char***)malloc(1000 * sizeof(char**));
    int resultSize = 0;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize && !found; i++) {
            Node* current = queue[front++];
            char* currWord = current->word;
            int currLevel = current->level;

            for (int j = 0; j < strlen(currWord); j++) {
                char originalChar = currWord[j];
                for (char c = 'a'; c <= 'z'; c++) {
                    if (c == originalChar)
                        continue;
                    currWord[j] = c;
                    char* newWord = strdup(currWord);
                    if (getFromHashTable(dict, newWord) != -1) {
                        if (getFromHashTable(visited, newWord) == -1) {
                            Node* newNode = (Node*)malloc(sizeof(Node));
                            newNode->word = newWord;
                            newNode->level = currLevel + 1;
                            newNode->path = (char**)malloc((currLevel + 2) * sizeof(char*));
                            memcpy(newNode->path, current->path, (currLevel + 1) * sizeof(char*));
                            newNode->path[currLevel + 1] = newWord;
                            newNode->pathSize = currLevel + 2;
                            queue[rear++] = newNode;
                            insertIntoHashTable(visited, newWord, 1);
                        } else if (getFromHashTable(visited, newWord) == 1) {
                            if (currLevel + 1 == current->level) {
                                Node* newNode = (Node*)malloc(sizeof(Node));
                                newNode->word = newWord;
                                newNode->level = currLevel + 1;
                                newNode->path = (char**)malloc((currLevel + 2) * sizeof(char*));
                                memcpy(newNode->path, current->path, (currLevel + 1) * sizeof(char*));
                                newNode->path[currLevel + 1] = newWord;
                                newNode->pathSize = currLevel + 2;
                                queue[rear++] = newNode;
                            }
                        }
                    }
                    currWord[j] = originalChar;
                }
            }

            if (strcmp(currWord, *endWord) == 0) {
                result[resultSize++] = current->path;
                found = 1;
            }
        }
    }

    *returnSize = resultSize;
    return result;
}