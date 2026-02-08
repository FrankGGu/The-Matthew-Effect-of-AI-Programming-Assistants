typedef struct TrieNode {
    struct TrieNode* children[26];
    char* word;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->word = NULL;
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
    node->word = word;
}

char* searchRoot(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            break;
        }
        node = node->children[idx];
        if (node->word) {
            return node->word;
        }
    }
    return word;
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    char* result = (char*)malloc(strlen(sentence) * 2);
    result[0] = '\0';

    char* token = strtok(sentence, " ");
    while (token) {
        char* rootWord = searchRoot(root, token);
        strcat(result, rootWord);
        token = strtok(NULL, " ");
        if (token) {
            strcat(result, " ");
        }
    }

    return result;
}