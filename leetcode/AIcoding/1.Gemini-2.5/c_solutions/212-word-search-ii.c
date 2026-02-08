#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    char* word;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->word = NULL;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        if (curr->children[idx] == NULL) {
            curr->children[idx] = createTrieNode();
        }
        curr = curr->children[idx];
    }
    curr->word = strdup(word);
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            freeTrie(node->children[i]);
        }
    }
    if (node->word) {
        free(node->word);
    }
    free(node);
}

void dfs(char** board, int boardRowSize, int boardColSize, int r, int c, TrieNode* node, char*** result, int* resultSize, int* resultCapacity) {
    if (r < 0 || r >= boardRowSize || c < 0 || c >= boardColSize) {
        return;
    }

    char ch = board[r][c];
    if (ch == '#') {
        return;
    }

    int idx = ch - 'a';
    if (node->children[idx] == NULL) {
        return;
    }

    node = node->children[idx];

    if (node->word != NULL) {
        if (*resultSize == *resultCapacity) {
            *resultCapacity = (*resultCapacity == 0) ? 1 : (*resultCapacity * 2);
            *result = (char**)realloc(*result, sizeof(char*) * (*resultCapacity));
        }
        (*result)[(*resultSize)++] = node->word;
        node->word = NULL;
    }

    board[r][c] = '#';

    dfs(board, boardRowSize, boardColSize, r + 1, c, node, result, resultSize, resultCapacity);
    dfs(board, boardRowSize, boardColSize, r - 1, c, node, result, resultSize, resultCapacity);
    dfs(board, boardRowSize, boardColSize, r, c + 1, node, result, resultSize, resultCapacity);
    dfs(board, boardRowSize, boardColSize, r, c - 1, node, result, resultSize, resultCapacity);

    board[r][c] = ch;
}

char** findWords(char** board, int boardRowSize, int boardColSize, char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createTrieNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char** result = NULL;
    int resultSize = 0;
    int resultCapacity = 0;

    for (int i = 0; i < boardRowSize; i++) {
        for (int j = 0; j < boardColSize; j++) {
            dfs(board, boardRowSize, boardColSize, i, j, root, &result, &resultSize, &resultCapacity);
        }
    }

    *returnSize = resultSize;
    freeTrie(root);
    return result;
}