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

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        if (node->children[idx] == NULL) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
        node->count++;
    }
}

int calculateScore(TrieNode* root, char* word) {
    TrieNode* node = root;
    int score = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        node = node->children[idx];
        score += node->count;
    }
    return score;
}

int* sumPrefixScores(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    int* result = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        result[i] = calculateScore(root, words[i]);
    }

    *returnSize = wordsSize;
    return result;
}