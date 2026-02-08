typedef struct TrieNode {
    struct TrieNode* children[26];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->count = 0;
    return node;
}

long long countPrefixSuffixPairs(char** words, int wordsSize) {
    TrieNode* root = createNode();
    long long res = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* s = words[i];
        int n = strlen(s);

        TrieNode* node = root;
        for (int j = 0; j < n; j++) {
            int idx1 = s[j] - 'a';
            int idx2 = s[n - 1 - j] - 'a';

            if (node->children[idx1] == NULL) {
                node->children[idx1] = createNode();
            }
            node = node->children[idx1];

            if (idx1 == idx2) {
                res += node->count;
            }
        }
        node->count++;
    }

    return res;
}