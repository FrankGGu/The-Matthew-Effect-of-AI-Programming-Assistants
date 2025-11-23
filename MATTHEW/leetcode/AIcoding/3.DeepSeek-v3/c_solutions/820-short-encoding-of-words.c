typedef struct TrieNode {
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

int cmp(const void* a, const void* b) {
    return strlen(*(char**)b) - strlen(*(char**)a);
}

int minimumLengthEncoding(char** words, int wordsSize) {
    if (wordsSize == 0) return 0;

    TrieNode* root = createNode();
    int res = 0;

    qsort(words, wordsSize, sizeof(char*), cmp);

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        TrieNode* cur = root;
        bool isNew = false;

        for (int j = len - 1; j >= 0; j--) {
            int idx = word[j] - 'a';
            if (cur->children[idx] == NULL) {
                isNew = true;
                cur->children[idx] = createNode();
            }
            cur = cur->children[idx];
        }

        if (isNew) {
            res += len + 1;
        }
    }

    return res;
}