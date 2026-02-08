#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    bool isEnd;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isEnd = false;
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
    curr->isEnd = true;
}

char* findRoot(TrieNode* root, char* word) {
    TrieNode* curr = root;
    int len = 0;
    while (word[len] != '\0') {
        int index = word[len] - 'a';
        if (curr->children[index] == NULL) {
            return word;
        }
        curr = curr->children[index];
        if (curr->isEnd) {
            word[len + 1] = '\0';
            return word;
        }
        len++;
    }
    return word;
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    int sentenceLen = strlen(sentence);
    char* result = (char*)malloc(sizeof(char) * (sentenceLen + 1));
    result[0] = '\0';

    char* token = strtok(sentence, " ");
    while (token != NULL) {
        char* newWord = findRoot(root, token);
        strcat(result, newWord);
        strcat(result, " ");
        token = strtok(NULL, " ");
    }

    result[strlen(result) - 1] = '\0';
    return result;
}