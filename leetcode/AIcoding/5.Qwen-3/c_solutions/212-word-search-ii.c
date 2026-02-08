#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    char* word;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; ++i) {
        node->children[i] = NULL;
    }
    node->word = NULL;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; i < strlen(word); ++i) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createTrieNode();
        }
        node = node->children[index];
    }
    node->word = strdup(word);
}

void dfs(char** board, int m, int n, int i, int j, TrieNode* node, bool** visited, char*** result, int* returnSize) {
    if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j]) {
        return;
    }

    char c = board[i][j];
    int index = c - 'a';
    if (!node->children[index]) {
        return;
    }

    node = node->children[index];
    if (node->word) {
        *returnSize += 1;
        (*result) = (char**)realloc(*result, *returnSize * sizeof(char*));
        (*result)[*returnSize - 1] = strdup(node->word);
        node->word = NULL;
    }

    visited[i][j] = true;
    dfs(board, m, n, i + 1, j, node, visited, result, returnSize);
    dfs(board, m, n, i - 1, j, node, visited, result, returnSize);
    dfs(board, m, n, i, j + 1, node, visited, result, returnSize);
    dfs(board, m, n, i, j - 1, node, visited, result, returnSize);
    visited[i][j] = false;
}

char** findWords(char** board, int boardSize, int* boardColSize, char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createTrieNode();
    for (int i = 0; i < wordsSize; ++i) {
        insert(root, words[i]);
    }

    *returnSize = 0;
    char** result = (char**)malloc(0);

    bool** visited = (bool**)malloc(boardSize * sizeof(bool*));
    for (int i = 0; i < boardSize; ++i) {
        visited[i] = (bool*)malloc(*boardColSize * sizeof(bool));
        memset(visited[i], false, *boardColSize * sizeof(bool));
    }

    for (int i = 0; i < boardSize; ++i) {
        for (int j = 0; j < *boardColSize; ++j) {
            dfs(board, boardSize, *boardColSize, i, j, root, visited, &result, returnSize);
        }
    }

    for (int i = 0; i < boardSize; ++i) {
        free(visited[i]);
    }
    free(visited);

    return result;
}