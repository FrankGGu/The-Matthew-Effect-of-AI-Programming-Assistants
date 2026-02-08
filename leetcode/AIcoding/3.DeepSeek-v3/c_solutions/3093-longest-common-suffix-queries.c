typedef struct TrieNode {
    struct TrieNode* children[26];
    int minLen;
    int idx;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->minLen = INT_MAX;
    node->idx = -1;
    return node;
}

void insert(TrieNode* root, char* word, int index) {
    TrieNode* node = root;
    int len = strlen(word);

    if (len < node->minLen) {
        node->minLen = len;
        node->idx = index;
    }

    for (int i = len - 1; i >= 0; i--) {
        int ch = word[i] - 'a';
        if (node->children[ch] == NULL) {
            node->children[ch] = createNode();
        }
        node = node->children[ch];

        if (len < node->minLen) {
            node->minLen = len;
            node->idx = index;
        }
    }
}

int query(TrieNode* root, char* word) {
    TrieNode* node = root;
    int len = strlen(word);

    for (int i = len - 1; i >= 0; i--) {
        int ch = word[i] - 'a';
        if (node->children[ch] == NULL) {
            break;
        }
        node = node->children[ch];
    }

    return node->idx;
}

int* stringIndices(char** wordsContainer, int wordsContainerSize, char** wordsQuery, int wordsQuerySize, int* returnSize) {
    TrieNode* root = createNode();

    int shortestIdx = 0;
    int shortestLen = INT_MAX;
    for (int i = 0; i < wordsContainerSize; i++) {
        int len = strlen(wordsContainer[i]);
        if (len < shortestLen) {
            shortestLen = len;
            shortestIdx = i;
        }
        insert(root, wordsContainer[i], i);
    }

    root->idx = shortestIdx;

    int* result = (int*)malloc(wordsQuerySize * sizeof(int));
    *returnSize = wordsQuerySize;

    for (int i = 0; i < wordsQuerySize; i++) {
        int idx = query(root, wordsQuery[i]);
        result[i] = idx;
    }

    return result;
}