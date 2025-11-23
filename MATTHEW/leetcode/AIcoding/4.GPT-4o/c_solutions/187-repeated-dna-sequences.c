#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HASH_SIZE 4096

typedef struct Node {
    char *sequence;
    struct Node *next;
} Node;

unsigned int hash(char *s) {
    unsigned int hash = 0;
    for (int i = 0; i < 10; i++) {
        hash = (hash << 2) | (s[i] - 'A' + 1);
    }
    return hash % HASH_SIZE;
}

Node* createNode(char *sequence) {
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->sequence = strdup(sequence);
    newNode->next = NULL;
    return newNode;
}

void freeList(Node *head) {
    while (head) {
        Node *temp = head;
        head = head->next;
        free(temp->sequence);
        free(temp);
    }
}

char **findRepeatedDnaSequences(char *s, int *returnSize) {
    if (strlen(s) < 10) {
        *returnSize = 0;
        return NULL;
    }

    Node *hashTable[HASH_SIZE] = {NULL};
    char **result = (char **)malloc(100 * sizeof(char *));
    int count = 0;

    for (int i = 0; i <= strlen(s) - 10; i++) {
        char seq[11] = {0};
        strncpy(seq, s + i, 10);
        unsigned int idx = hash(seq);

        Node *temp = hashTable[idx];
        int found = 0;

        while (temp) {
            if (strcmp(temp->sequence, seq) == 0) {
                found = 1;
                break;
            }
            temp = temp->next;
        }

        if (found) {
            continue;
        }

        Node *newNode = createNode(seq);
        newNode->next = hashTable[idx];
        hashTable[idx] = newNode;

        if (temp) {
            result[count++] = strdup(seq);
        }
    }

    *returnSize = count;
    return result;
}