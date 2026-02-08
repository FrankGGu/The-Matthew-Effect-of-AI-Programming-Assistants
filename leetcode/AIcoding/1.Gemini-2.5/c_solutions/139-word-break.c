#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#define HASH_TABLE_SIZE 1009

typedef struct Node {
    char* word;
    struct Node* next;
} Node;

Node* hashTable[HASH_TABLE_SIZE];

unsigned int hash_n(const char* str, int len) {
    unsigned int h = 0;
    for (int i = 0; i < len; ++i) {
        h = (h << 5) + h + str[i];
    }
    return h % HASH_TABLE_SIZE;
}

void insert_word(const char* str) {
    unsigned int index = hash_n(str, strlen(str));
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->word = strdup(str);
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

bool contains_word(const char* str_ptr, int len) {
    unsigned int index = hash_n(str_ptr, len);
    Node* current = hashTable[index];
    while (current) {
        if (strlen(current->word) == len && strncmp(current->word, str_ptr, len) == 0) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void free_hash_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Node* current = hashTable[i];
        while (current) {
            Node* temp = current;
            current = current->next;
            free(temp->word);
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

bool wordBreak(char* s, char** wordDict, int wordDictSize) {
    memset(hashTable, 0, sizeof(hashTable));

    for (int i = 0; i < wordDictSize; ++i) {
        insert_word(wordDict[i]);
    }

    int n = strlen(s);
    bool dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = true;

    for (int i = 1; i <= n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (dp[j] && contains_word(s + j, i - j)) {
                dp[i] = true;
                break;
            }
        }
    }

    bool result = dp[n];
    free_hash_table();
    return result;
}