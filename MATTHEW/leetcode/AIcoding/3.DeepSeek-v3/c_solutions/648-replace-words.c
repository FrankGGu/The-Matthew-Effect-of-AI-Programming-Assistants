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
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        if (node->children[idx] == NULL) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
    }
    node->isEnd = true;
}

char* searchPrefix(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        if (node->children[idx] == NULL) {
            return NULL;
        }
        node = node->children[idx];
        if (node->isEnd) {
            char* prefix = (char*)malloc((i + 2) * sizeof(char));
            strncpy(prefix, word, i + 1);
            prefix[i + 1] = '\0';
            return prefix;
        }
    }
    return NULL;
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    char* result = (char*)malloc(100000 * sizeof(char));
    result[0] = '\0';

    char* token = strtok(sentence, " ");
    while (token != NULL) {
        char* prefix = searchPrefix(root, token);
        if (prefix != NULL) {
            strcat(result, prefix);
            free(prefix);
        } else {
            strcat(result, token);
        }

        token = strtok(NULL, " ");
        if (token != NULL) {
            strcat(result, " ");
        }
    }

    return result;
}