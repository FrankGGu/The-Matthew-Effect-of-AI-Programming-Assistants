#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_WORD_LEN 50
#define HASH_SIZE 1000

typedef struct Node {
    char word[MAX_WORD_LEN];
    int count;
    struct Node* next;
} Node;

unsigned int hash(char* word) {
    unsigned int hash = 0;
    while (*word) {
        hash = (hash << 5) + *word++;
    }
    return hash % HASH_SIZE;
}

Node* createNode(char* word) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    strcpy(newNode->word, word);
    newNode->count = 1;
    newNode->next = NULL;
    return newNode;
}

char* mostCommonWord(char* paragraph, char** banned, int bannedSize) {
    Node* hashTable[HASH_SIZE] = {0};
    int bannedMap[256] = {0};
    for (int i = 0; i < bannedSize; i++) {
        bannedMap[banned[i][0]] = 1;
    }

    char* token = strtok(paragraph, " !?',;.");
    while (token) {
        for (int i = 0; token[i]; i++) {
            token[i] = tolower(token[i]);
        }
        if (!bannedMap[token[0]]) {
            unsigned int index = hash(token);
            Node* current = hashTable[index];
            while (current) {
                if (strcmp(current->word, token) == 0) {
                    current->count++;
                    break;
                }
                current = current->next;
            }
            if (!current) {
                Node* newNode = createNode(token);
                newNode->next = hashTable[index];
                hashTable[index] = newNode;
            }
        }
        token = strtok(NULL, " !?',;.");
    }

    char* result = NULL;
    int maxCount = 0;
    for (int i = 0; i < HASH_SIZE; i++) {
        Node* current = hashTable[i];
        while (current) {
            if (current->count > maxCount) {
                maxCount = current->count;
                result = current->word;
            }
            current = current->next;
        }
    }

    return result;
}