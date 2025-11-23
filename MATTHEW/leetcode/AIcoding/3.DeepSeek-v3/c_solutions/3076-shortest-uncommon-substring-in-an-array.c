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
    while (*word) {
        int idx = *word - 'a';
        if (!node->children[idx]) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
        node->count++;
        word++;
    }
}

int search(TrieNode* root, char* word) {
    TrieNode* node = root;
    while (*word) {
        int idx = *word - 'a';
        if (!node->children[idx]) {
            return 0;
        }
        node = node->children[idx];
        word++;
    }
    return node->count;
}

char** shortestSubstrings(char** arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    char** result = (char**)malloc(arrSize * sizeof(char*));

    TrieNode* globalTrie = createNode();
    for (int i = 0; i < arrSize; i++) {
        int len = strlen(arr[i]);
        for (int j = 0; j < len; j++) {
            for (int k = j; k < len; k++) {
                char temp[21];
                int idx = 0;
                for (int m = j; m <= k; m++) {
                    temp[idx++] = arr[i][m];
                }
                temp[idx] = '\0';
                insert(globalTrie, temp);
            }
        }
    }

    for (int i = 0; i < arrSize; i++) {
        int len = strlen(arr[i]);
        char* best = NULL;

        for (int l = 1; l <= len; l++) {
            for (int j = 0; j <= len - l; j++) {
                char temp[21];
                int idx = 0;
                for (int k = j; k < j + l; k++) {
                    temp[idx++] = arr[i][k];
                }
                temp[idx] = '\0';

                if (search(globalTrie, temp) == 1) {
                    if (best == NULL || strcmp(temp, best) < 0) {
                        if (best) free(best);
                        best = (char*)malloc((l + 1) * sizeof(char));
                        strcpy(best, temp);
                    }
                }
            }
            if (best != NULL) break;
        }

        if (best == NULL) {
            result[i] = (char*)malloc(1 * sizeof(char));
            result[i][0] = '\0';
        } else {
            result[i] = best;
        }
    }

    return result;
}