typedef struct TrieNode {
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

int insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    int isNew = 0;
    int len = strlen(word);
    for (int i = len - 1; i >= 0; i--) {
        int c = word[i] - 'a';
        if (node->children[c] == NULL) {
            isNew = 1;
            node->children[c] = createTrieNode();
        }
        node = node->children[c];
    }
    return isNew ? len + 1 : 0;
}

int cmp(const void* a, const void* b) {
    return strlen(*(char**)b) - strlen(*(char**)a);
}

int minimumLengthEncoding(char** words, int wordsSize) {
    TrieNode* root = createTrieNode();
    qsort(words, wordsSize, sizeof(char*), cmp);
    int res = 0;
    for (int i = 0; i < wordsSize; i++) {
        res += insert(root, words[i]);
    }
    return res;
}