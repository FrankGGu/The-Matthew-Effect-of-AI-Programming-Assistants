typedef struct TrieNode {
    struct TrieNode* children[26];
    int len;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->len = 0;
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
        node->len = i + 1;
    }
}

int minValidStrings(char** words, int wordsSize, char* target) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    int n = strlen(target);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == INT_MAX) continue;

        TrieNode* node = root;
        for (int j = i; j < n; j++) {
            int idx = target[j] - 'a';
            if (!node->children[idx]) break;

            node = node->children[idx];
            if (dp[j + 1] > dp[i] + 1) {
                dp[j + 1] = dp[i] + 1;
            }
        }
    }

    int res = dp[n] == INT_MAX ? -1 : dp[n];

    free(dp);

    void freeTrie(TrieNode* node) {
        if (!node) return;
        for (int i = 0; i < 26; i++) {
            freeTrie(node->children[i]);
        }
        free(node);
    }
    freeTrie(root);

    return res;
}