#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct HashNode {
    char* key; // Pointer to the word in wordList
    int value; // Index of the word in wordList
    struct HashNode* next;
} HashNode;

HashNode** hashTable;
int hashTableCapacity; // Size of the hash table array
int currentWordLen; // Length of words, stored globally for hash function

unsigned int calculateHash(const char* s) {
    unsigned int h = 0;
    for (int i = 0; i < currentWordLen; i++) {
        h = (h * 31) + s[i];
    }
    return h % hashTableCapacity;
}

void initHashTable(int capacity, int len) {
    hashTableCapacity = capacity;
    currentWordLen = len;
    hashTable = (HashNode**)calloc(hashTableCapacity, sizeof(HashNode*));
}

void insertWord(char* key, int value) {
    unsigned int idx = calculateHash(key);
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key; // Store pointer to the original string
    newNode->value = value;
    newNode->next = hashTable[idx];
    hashTable[idx] = newNode;
}

int lookupWord(const char* key) {
    unsigned int idx = calculateHash(key);
    HashNode* current = hashTable[idx];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }
    return -1; // Not found
}

void freeHashTable() {
    for (int i = 0; i < hashTableCapacity; i++) {
        HashNode* current = hashTable[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(hashTable);
}

typedef struct {
    int* data;
    int head;
    int tail;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->head = 0;
    q->tail = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue* q, int val) {
    q->data[q->tail++] = val;
}

int dequeue(Queue* q) {
    return q->data[q->head++];
}

bool isQueueEmpty(Queue* q) {
    return q->head == q->tail;
}

int queueSize(Queue* q) {
    return q->tail - q->head;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int ladderLength(char* beginWord, char* endWord, char** wordList, int wordListSize) {
    if (wordListSize == 0) return 0;

    int wordLen = strlen(beginWord);

    initHashTable(wordListSize * 2 + 7, wordLen); 

    for (int i = 0; i < wordListSize; i++) {
        insertWord(wordList[i], i);
    }

    if (lookupWord(endWord) == -1) {
        freeHashTable();
        return 0;
    }

    bool* visited = (bool*)calloc(wordListSize, sizeof(bool));

    Queue* q = createQueue(wordListSize + 1);

    int level = 1; 

    char* tempWord = (char*)malloc(sizeof(char) * (wordLen + 1));
    strcpy(tempWord, beginWord);

    for (int i = 0; i < wordLen; i++) {
        char originalChar = tempWord[i];
        for (char c = 'a'; c <= 'z'; c++) {
            if (c == originalChar) continue;
            tempWord[i] = c;
            int neighborIdx = lookupWord(tempWord);
            if (neighborIdx != -1 && !visited[neighborIdx]) {
                if (strcmp(tempWord, endWord) == 0) { 
                    free(tempWord);
                    freeQueue(q);
                    free(visited);
                    freeHashTable();
                    return level + 1; 
                }
                enqueue(q, neighborIdx);
                visited[neighborIdx] = true;
            }
        }
        tempWord[i] = originalChar; 
    }

    level++; 

    while (!isQueueEmpty(q)) {
        int currentLevelSize = queueSize(q);
        for (int k = 0; k < currentLevelSize; k++) {
            int wordIdx = dequeue(q);
            char* word = wordList[wordIdx]; 

            if (strcmp(word, endWord) == 0) {
                free(tempWord);
                freeQueue(q);
                free(visited);
                freeHashTable();
                return level;
            }

            strcpy(tempWord, word); 
            for (int i = 0; i < wordLen; i++) {
                char originalChar = tempWord[i];
                for (char c = 'a'; c <= 'z'; c++) {
                    if (c == originalChar) continue;
                    tempWord[i] = c;
                    int neighborIdx = lookupWord(tempWord);
                    if (neighborIdx != -1 && !visited[neighborIdx]) {
                        if (strcmp(tempWord, endWord) == 0) { 
                            free(tempWord);
                            freeQueue(q);
                            free(visited);
                            freeHashTable();
                            return level + 1;
                        }
                        enqueue(q, neighborIdx);
                        visited[neighborIdx] = true;
                    }
                }
                tempWord[i] = originalChar; 
            }
        }
        level++;
    }

    free(tempWord);
    freeQueue(q);
    free(visited);
    freeHashTable();
    return 0;
}