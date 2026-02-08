/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEnd;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = false;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
    }
    node->isEnd = true;
}

void backtrack(char* s, int start, TrieNode* root, char* current, int len, char** result, int* returnSize) {
    if (start == strlen(s)) {
        current[len - 1] = '\0';
        result[*returnSize] = (char*)malloc(len * sizeof(char));
        strcpy(result[*returnSize], current);
        (*returnSize)++;
        return;
    }

    TrieNode* node = root;
    for (int i = start; i < strlen(s); i++) {
        int idx = s[i] - 'a';
        if (!node->children[idx]) {
            return;
        }
        node = node->children[idx];
        if (node->isEnd) {
            int newLen = len + (i - start + 1) + 1;
            if (newLen > 1000) continue;
            for (int j = 0; j <= i - start; j++) {
                current[len + j] = s[start + j];
            }
            current[len + (i - start)] = ' ';
            backtrack(s, i + 1, root, current, newLen, result, returnSize);
        }
    }
}

char** wordBreak(char* s, char** wordDict, int wordDictSize, int* returnSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordDictSize; i++) {
        insert(root, wordDict[i]);
    }

    char** result = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;
    char* current = (char*)malloc(1000 * sizeof(char));

    backtrack(s, 0, root, current, 0, result, returnSize);

    free(current);

    TrieNode* stack[1000];
    int top = 0;
    stack[top++] = root;
    while (top > 0) {
        TrieNode* node = stack[--top];
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                stack[top++] = node->children[i];
            }
        }
        free(node);
    }

    return result;
}