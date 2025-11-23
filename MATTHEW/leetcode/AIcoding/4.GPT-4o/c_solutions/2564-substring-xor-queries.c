typedef long long ll;

struct TrieNode {
    struct TrieNode *children[2];
    int count;
};

struct TrieNode* createNode() {
    struct TrieNode* node = (struct TrieNode*)malloc(sizeof(struct TrieNode));
    node->children[0] = node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(struct TrieNode *root, int num) {
    struct TrieNode *node = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!node->children[bit]) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
        node->count++;
    }
}

int query(struct TrieNode *root, int num) {
    struct TrieNode *node = root;
    int maxXor = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (node->children[!bit] && node->children[!bit]->count > 0) {
            maxXor |= (1 << i);
            node = node->children[!bit];
        } else {
            node = node->children[bit];
        }
    }
    return maxXor;
}

ll* substringXorQueries(char *s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    struct TrieNode *root = createNode();
    int n = strlen(s);
    ll *result = (ll *)malloc(queriesSize * sizeof(ll));
    int *prefixXor = (int *)malloc((n + 1) * sizeof(int));
    prefixXor[0] = 0;

    for (int i = 0; i < n; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ (s[i] - '0');
        insert(root, prefixXor[i + 1]);
    }

    for (int i = 0; i < queriesSize; i++) {
        ll a = queries[i][0];
        int found = 0;
        for (int j = 0; j <= n; j++) {
            if (prefixXor[j] == a) {
                result[i] = (ll)j - (ll)0; // Start index 0
                found = 1;
                break;
            }
            int target = prefixXor[j] ^ a;
            if (query(root, target) == a) {
                result[i] = (ll)j - (ll)0; // Start index 0
                found = 1;
                break;
            }
        }
        if (!found) {
            result[i] = -1;
        }
    }

    *returnSize = queriesSize;
    free(prefixXor);
    return result;
}