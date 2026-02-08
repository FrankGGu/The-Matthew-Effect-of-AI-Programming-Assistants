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

bool dfs(char* word, TrieNode* root, int index, int count) {
    TrieNode* node = root;
    for (int i = index; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            return false;
        }
        node = node->children[idx];
        if (node->isEnd) {
            if (word[i + 1] == '\0') {
                return count >= 1;
            }
            if (dfs(word, root, i + 1, count + 1)) {
                return true;
            }
        }
    }
    return false;
}

int cmp(const void* a, const void* b) {
    return strlen(*(char**)a) - strlen(*(char**)b);
}

char** findAllConcatenatedWordsInADict(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();
    *returnSize = 0;

    qsort(words, wordsSize, sizeof(char*), cmp);

    char** result = (char**)malloc(wordsSize * sizeof(char*));

    for (int i = 0; i < wordsSize; i++) {
        if (strlen(words[i]) == 0) continue;
        if (dfs(words[i], root, 0, 0)) {
            result[(*returnSize)++] = words[i];
        } else {
            insert(root, words[i]);
        }
    }

    return result;
}