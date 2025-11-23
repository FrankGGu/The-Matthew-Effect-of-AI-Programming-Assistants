typedef struct TrieNode {
    struct TrieNode *children[26];
    char *word;
} TrieNode;

TrieNode *createNode() {
    TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->word = NULL;
    return node;
}

void insert(TrieNode *root, char *word) {
    TrieNode *node = root;
    for (int i = 0; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
    }
    node->word = word;
}

void backtrack(char **board, int boardSize, int *boardColSize, TrieNode *node, int i, int j, char **result, int *returnSize) {
    if (i < 0 || i >= boardSize || j < 0 || j >= boardColSize[0] || board[i][j] == '#') {
        return;
    }

    char c = board[i][j];
    int idx = c - 'a';
    if (!node->children[idx]) {
        return;
    }

    node = node->children[idx];
    if (node->word) {
        result[*returnSize] = node->word;
        (*returnSize)++;
        node->word = NULL;
    }

    board[i][j] = '#';
    backtrack(board, boardSize, boardColSize, node, i + 1, j, result, returnSize);
    backtrack(board, boardSize, boardColSize, node, i - 1, j, result, returnSize);
    backtrack(board, boardSize, boardColSize, node, i, j + 1, result, returnSize);
    backtrack(board, boardSize, boardColSize, node, i, j - 1, result, returnSize);
    board[i][j] = c;
}

char **findWords(char **board, int boardSize, int *boardColSize, char **words, int wordsSize, int *returnSize) {
    TrieNode *root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char **result = (char **)malloc(wordsSize * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[0]; j++) {
            backtrack(board, boardSize, boardColSize, root, i, j, result, returnSize);
        }
    }

    return result;
}