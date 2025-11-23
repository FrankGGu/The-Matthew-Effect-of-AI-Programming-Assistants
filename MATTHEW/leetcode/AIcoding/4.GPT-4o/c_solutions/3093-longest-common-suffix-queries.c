typedef struct TrieNode {
    struct TrieNode *children[26];
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

void insert(TrieNode *root, const char *word) {
    int len = strlen(word);
    for (int i = len - 1; i >= 0; i--) {
        int index = word[i] - 'a';
        if (root->children[index] == NULL) {
            root->children[index] = createNode();
        }
        root = root->children[index];
        root->count++;
    }
}

int countSuffixes(TrieNode *root, const char *suffix) {
    int len = strlen(suffix);
    for (int i = len - 1; i >= 0; i--) {
        int index = suffix[i] - 'a';
        if (root->children[index] == NULL) {
            return 0;
        }
        root = root->children[index];
    }
    return root->count;
}

int* longestCommonSuffixQueries(char **words, int wordsSize, char **queries, int queriesSize, int *returnSize) {
    TrieNode *root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    int *result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        result[i] = countSuffixes(root, queries[i]);
    }

    return result;
}