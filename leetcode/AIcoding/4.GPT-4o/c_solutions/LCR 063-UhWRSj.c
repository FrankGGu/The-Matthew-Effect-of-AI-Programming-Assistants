#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TrieNode {
    struct TrieNode *children[26];
    int isEnd;
};

struct TrieNode* createNode() {
    struct TrieNode *node = (struct TrieNode *)malloc(sizeof(struct TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

void insert(struct TrieNode *root, const char *word) {
    struct TrieNode *cur = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!cur->children[index]) {
            cur->children[index] = createNode();
        }
        cur = cur->children[index];
    }
    cur->isEnd = 1;
}

char* findRoot(struct TrieNode *root, const char *word) {
    struct TrieNode *cur = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!cur->children[index]) {
            return NULL;
        }
        if (cur->children[index]->isEnd) {
            return strndup(word, i + 1);
        }
        cur = cur->children[index];
    }
    return NULL;
}

char* replaceWords(char **dict, int dictSize, char *sentence) {
    struct TrieNode *root = createNode();
    for (int i = 0; i < dictSize; i++) {
        insert(root, dict[i]);
    }

    char *result = (char *)malloc(1000);
    result[0] = '\0';
    char *token = strtok(sentence, " ");
    while (token) {
        char *rootWord = findRoot(root, token);
        if (rootWord) {
            strcat(result, rootWord);
            free(rootWord);
        } else {
            strcat(result, token);
        }
        strcat(result, " ");
        token = strtok(NULL, " ");
    }
    result[strlen(result) - 1] = '\0'; // Remove trailing space
    return result;
}