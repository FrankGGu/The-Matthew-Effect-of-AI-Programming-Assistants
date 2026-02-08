#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TrieNode {
    struct TrieNode *children[26];
    int isEnd;
};

struct TrieNode* createNode() {
    struct TrieNode* node = (struct TrieNode*)malloc(sizeof(struct TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

void insert(struct TrieNode* root, char* word) {
    struct TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
}

char* replaceRoot(struct TrieNode* root, char* word) {
    struct TrieNode* node = root;
    char* prefix = (char*)malloc(strlen(word) + 1);
    int len = 0;

    for (int i = 0; word[i]; i++) {
        if (node->isEnd) {
            prefix[len] = '\0';
            return prefix;
        }
        int index = word[i] - 'a';
        if (!node->children[index]) {
            break;
        }
        prefix[len++] = word[i];
        node = node->children[index];
    }
    prefix[len] = '\0';
    return len > 0 ? prefix : word;
}

char* replaceWords(char** dict, int dictSize, char* sentence) {
    struct TrieNode* root = createNode();
    for (int i = 0; i < dictSize; i++) {
        insert(root, dict[i]);
    }

    char* result = (char*)malloc(strlen(sentence) + 1);
    result[0] = '\0';
    char* token = strtok(sentence, " ");

    while (token) {
        char* rootWord = replaceRoot(root, token);
        strcat(result, rootWord);
        strcat(result, " ");
        if (rootWord != token) free(rootWord);
        token = strtok(NULL, " ");
    }

    if (result[strlen(result) - 1] == ' ') {
        result[strlen(result) - 1] = '\0';
    }

    return result;
}

char** split(char* str, int* returnSize) {
    char** result = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;
    char* token = strtok(str, " ");

    while (token) {
        result[(*returnSize)++] = token;
        token = strtok(NULL, " ");
    }
    return result;
}

char* replaceWordsMain(char** dict, int dictSize, char* sentence) {
    return replaceWords(dict, dictSize, sentence);
}