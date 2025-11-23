#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define HASH_TABLE_SIZE 1009 

typedef struct Node {
    char* key;
    struct Node* next;
} Node;

typedef struct HashSet {
    Node** buckets;
    int size;
} HashSet;

unsigned int hash(const char* s) {
    unsigned int h = 0;
    while (*s) {
        h = (h * 31) + (*s++);
    }
    return h % HASH_TABLE_SIZE;
}

HashSet* createHashSet() {
    HashSet* hs = (HashSet*)malloc(sizeof(HashSet));
    hs->buckets = (Node**)calloc(HASH_TABLE_SIZE, sizeof(Node*));
    hs->size = 0;
    return hs;
}

void hashSetAdd(HashSet* hs, const char* s) {
    unsigned int index = hash(s);
    Node* current = hs->buckets[index];
    while (current != NULL) {
        if (strcmp(current->key, s) == 0) {
            return;
        }
        current = current->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = strdup(s);
    newNode->next = hs->buckets[index];
    hs->buckets[index] = newNode;
    hs->size++;
}

bool hashSetContains(HashSet* hs, const char* s) {
    unsigned int index = hash(s);
    Node* current = hs->buckets[index];
    while (current != NULL) {
        if (strcmp(current->key, s) == 0) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void freeHashSet(HashSet* hs) {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Node* current = hs->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp->key);
            free(temp);
        }
    }
    free(hs->buckets);
    free(hs);
}

int compareStrings(const void* a, const void* b) {
    const char* str1 = *(const char**)a;
    const char* str2 = *(const char**)b;
    return strcmp(str1, str2);
}

char* longestWord(char** words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char*), compareStrings);

    HashSet* validWords = createHashSet();
    char* longest = (char*)calloc(1, sizeof(char)); 

    for (int i = 0; i < wordsSize; ++i) {
        char* currentWord = words[i];
        int len = strlen(currentWord);

        bool canBuild = false;
        if (len == 1) {
            canBuild = true;
        } else {
            char* prefix = (char*)malloc(len);
            strncpy(prefix, currentWord, len - 1);
            prefix[len - 1] = '\0';

            if (hashSetContains(validWords, prefix)) {
                canBuild = true;
            }
            free(prefix);
        }

        if (canBuild) {
            hashSetAdd(validWords, currentWord);

            if (len > strlen(longest)) {
                free(longest);
                longest = strdup(currentWord);
            } else if (len == strlen(longest)) {
                if (strcmp(currentWord, longest) < 0) {
                    free(longest);
                    longest = strdup(currentWord);
                }
            }
        }
    }

    freeHashSet(validWords);
    return longest;
}