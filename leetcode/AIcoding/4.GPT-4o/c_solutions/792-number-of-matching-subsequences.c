#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    struct Node *next;
} Node;

typedef struct {
    Node **buckets;
    int size;
} HashTable;

HashTable *createHashTable(int size) {
    HashTable *ht = malloc(sizeof(HashTable));
    ht->buckets = calloc(size, sizeof(Node *));
    ht->size = size;
    return ht;
}

unsigned long hash(char *s) {
    unsigned long h = 5381;
    int c;
    while ((c = *s++)) {
        h = ((h << 5) + h) + c;
    }
    return h;
}

void insert(HashTable *ht, char *word) {
    unsigned long index = hash(word) % ht->size;
    Node *newNode = malloc(sizeof(Node));
    newNode->word = word;
    newNode->next = ht->buckets[index];
    ht->buckets[index] = newNode;
}

int isSubsequence(char *s, char *t) {
    while (*s && *t) {
        if (*s == *t) s++;
        t++;
    }
    return *s == '\0';
}

int numMatchingSubseq(char *s, char **words, int wordsSize) {
    HashTable *ht = createHashTable(1000);
    for (int i = 0; i < wordsSize; i++) {
        insert(ht, words[i]);
    }

    int count = 0;
    for (int i = 0; i < ht->size; i++) {
        Node *node = ht->buckets[i];
        while (node) {
            if (isSubsequence(node->word, s)) {
                count++;
            }
            node = node->next;
        }
    }

    return count;
}

int numMatchingSubseq(char * s, char ** words, int wordsSize) {
    return numMatchingSubseq(s, words, wordsSize);
}