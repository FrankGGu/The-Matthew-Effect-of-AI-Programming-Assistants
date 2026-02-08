#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 1000

typedef struct TrieNode {
    int isWord;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isWord = 0;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            curr->children[index] = createNode();
        }
        curr = curr->children[index];
    }
    curr->isWord = 1;
}

char* findRoot(TrieNode* root, char* word) {
    TrieNode* curr = root;
    int len = strlen(word);
    char* rootWord = (char*)malloc(sizeof(char) * (len + 1));
    int i = 0;
    for (; i < len; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            free(rootWord);
            return NULL;
        }
        rootWord[i] = word[i];
        curr = curr->children[index];
        if (curr->isWord) {
            rootWord[i + 1] = '\0';
            return rootWord;
        }
    }
    free(rootWord);
    return NULL;
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    char* result = (char*)malloc(sizeof(char) * (strlen(sentence) + 1));
    result[0] = '\0';

    char* token = strtok(sentence, " ");
    while (token != NULL) {
        char* rootWord = findRoot(root, token);
        if (rootWord != NULL) {
            strcat(result, rootWord);
            free(rootWord);
        } else {
            strcat(result, token);
        }
        strcat(result, " ");
        token = strtok(NULL, " ");
    }

    if (result[0] != '\0') {
      result[strlen(result) - 1] = '\0';
    }

    return result;
}