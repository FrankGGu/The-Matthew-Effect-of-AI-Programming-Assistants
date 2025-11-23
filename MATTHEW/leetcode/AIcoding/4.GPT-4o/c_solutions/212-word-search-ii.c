#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode *children[26];
    int isEnd;
} TrieNode;

typedef struct {
    char **board;
    int rows, cols;
    TrieNode *root;
    char **result;
    int resultSize;
} WordSearch;

TrieNode* createNode() {
    TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) node->children[i] = NULL;
    node->isEnd = 0;
    return node;
}

void insert(TrieNode *root, char *word) {
    TrieNode *node = root;
    while (*word) {
        if (!node->children[*word - 'a']) {
            node->children[*word - 'a'] = createNode();
        }
        node = node->children[*word - 'a'];
        word++;
    }
    node->isEnd = 1;
}

void dfs(WordSearch *ws, int x, int y, TrieNode *node, char *path, int length) {
    if (node->isEnd) {
        ws->result = realloc(ws->result, sizeof(char *) * (ws->resultSize + 1));
        ws->result[ws->resultSize] = strndup(path, length);
        ws->resultSize++;
        node->isEnd = 0; // prevent duplicates
    }
    if (x < 0 || y < 0 || x >= ws->rows || y >= ws->cols || ws->board[x][y] == '#' || !node->children[ws->board[x][y] - 'a']) return;

    char temp = ws->board[x][y];
    ws->board[x][y] = '#'; // mark as visited
    path[length] = temp;
    path[length + 1] = '\0';

    dfs(ws, x + 1, y, node->children[temp - 'a'], path, length + 1);
    dfs(ws, x - 1, y, node->children[temp - 'a'], path, length + 1);
    dfs(ws, x, y + 1, node->children[temp - 'a'], path, length + 1);
    dfs(ws, x, y - 1, node->children[temp - 'a'], path, length + 1);

    ws->board[x][y] = temp; // unmark
}

char **findWords(char **board, int boardSize, int *boardColSize, char **words, int wordsSize, int *returnSize) {
    WordSearch ws;
    ws.rows = boardSize;
    ws.cols = *boardColSize;
    ws.board = board;
    ws.result = NULL;
    ws.resultSize = 0;

    ws.root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(ws.root, words[i]);
    }

    char path[15];
    for (int i = 0; i < ws.rows; i++) {
        for (int j = 0; j < ws.cols; j++) {
            dfs(&ws, i, j, ws.root, path, 0);
        }
    }

    *returnSize = ws.resultSize;
    return ws.result;
}