#define MAX_LEN 1001

typedef struct {
    int next[MAX_LEN];
    int len;
} Trie;

int insert(Trie* trie, char* s, int len) {
    int node = 0, count = 0;
    for (int i = 0; i < len; i++) {
        int index = s[i] - 'a';
        if (!trie[node].next[index]) {
            trie[node].next[index] = ++trie->len;
            count++;
        }
        node = trie[node].next[index];
    }
    return count;
}

int distinctEchoSubstrings(char * text) {
    int n = strlen(text);
    Trie trie = {0};
    int count = 0;

    for (int len = 1; len <= n / 2; len++) {
        for (int i = 0; i <= n - 2 * len; i++) {
            if (strncmp(text + i, text + i + len, len) == 0) {
                count += insert(&trie, text + i, len);
            }
        }
    }

    return count;
}