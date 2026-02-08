#define MAX_LEN 100

struct StreamChecker {
    struct TrieNode {
        struct TrieNode *children[26];
        bool isEnd;
    };

    struct TrieNode *root;
    char stream[MAX_LEN];
    int idx;

    struct TrieNode* createNode() {
        struct TrieNode *node = (struct TrieNode *)malloc(sizeof(struct TrieNode));
        for (int i = 0; i < 26; i++) {
            node->children[i] = NULL;
        }
        node->isEnd = false;
        return node;
    }

    void insert(struct TrieNode *root, char *word) {
        struct TrieNode *node = root;
        for (int i = 0; word[i] != '\0'; i++) {
            int index = word[i] - 'a';
            if (!node->children[index]) {
                node->children[index] = createNode();
            }
            node = node->children[index];
        }
        node->isEnd = true;
    }

    struct StreamChecker* streamCheckerCreate(char **words, int wordsSize) {
        struct StreamChecker *sc = (struct StreamChecker *)malloc(sizeof(struct StreamChecker));
        sc->root = createNode();
        sc->idx = 0;
        for (int i = 0; i < wordsSize; i++) {
            int len = strlen(words[i]);
            char *revWord = (char *)malloc(len + 1);
            for (int j = 0; j < len; j++) {
                revWord[j] = words[i][len - j - 1];
            }
            revWord[len] = '\0';
            insert(sc->root, revWord);
            free(revWord);
        }
        return sc;
    }

    bool query(struct StreamChecker *sc, char letter) {
        sc->stream[sc->idx++] = letter;
        struct TrieNode *node = sc->root;
        for (int i = sc->idx - 1; i >= 0; i--) {
            int index = sc->stream[i] - 'a';
            if (!node->children[index]) {
                return false;
            }
            node = node->children[index];
            if (node->isEnd) {
                return true;
            }
        }
        return false;
    }

    void streamCheckerFree(struct StreamChecker *sc) {
        if (sc) {
            free(sc);
        }
    }
};