typedef struct {
    char **words;
    int size;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->words = (char**)malloc(26 * sizeof(char*));
    for (int i = 0; i < 26; i++) {
        node->words[i] = NULL;
    }
    node->size = 0;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->words[index]) {
            node->words[index] = createNode();
        }
        node = node->words[index];
    }
    node->words[26] = word;
}

int canForm(TrieNode* root, char* word, int start, int count) {
    TrieNode* node = root;
    for (int i = start; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->words[index]) {
            return 0;
        }
        node = node->words[index];
        if (node->words[26]) {
            if (canForm(root, word, i + 1, count + 1) || (i + 1 == strlen(word) && count >= 1)) {
                return 1;
            }
        }
    }
    return 0;
}

char** findAllConcatenatedWordsInADict(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (canForm(root, words[i], 0, 0)) {
            result[(*returnSize)++] = words[i];
        }
    }

    return result;
}