#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    char* word;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        node->children[i] = NULL;
    }
    node->word = NULL;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* current = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createTrieNode();
        }
        current = current->children[index];
    }
    current->word = word;
}

void dfs(char** board, int boardSize, int* boardColSize, int row, int col, TrieNode* node, char** result, int* resultSize) {
    if (row < 0 || row >= boardSize || col < 0 || col >= boardColSize[0] || board[row][col] == '#' || node->children[board[row][col] - 'a'] == NULL) {
        return;
    }

    char originalChar = board[row][col];
    node = node->children[originalChar - 'a'];

    if (node->word != NULL) {
        result[*resultSize] = node->word;
        (*resultSize)++;
        node->word = NULL; 
    }

    board[row][col] = '#';

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int i = 0; i < 4; i++) {
        dfs(board, boardSize, boardColSize, row + directions[i][0], col + directions[i][1], node, result, resultSize);
    }

    board[row][col] = originalChar;
}

char** findWords(char** board, int boardSize, int* boardColSize, char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createTrieNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char** result = (char**)malloc(sizeof(char*) * wordsSize);
    *returnSize = 0;

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[0]; j++) {
            dfs(board, boardSize, boardColSize, i, j, root, result, returnSize);
        }
    }

    char** finalResult = (char**)malloc(sizeof(char*) * (*returnSize));
    for (int i = 0; i < *returnSize; i++) {
        finalResult[i] = result[i];
    }

    free(result);
    return finalResult;
}