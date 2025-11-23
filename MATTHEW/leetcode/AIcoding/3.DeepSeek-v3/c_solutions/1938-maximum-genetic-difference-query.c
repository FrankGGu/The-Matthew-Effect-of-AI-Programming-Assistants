#define MAX_NODES 200000
#define MAX_QUERIES 200000
#define MAX_BITS 18

typedef struct {
    int node;
    int val;
    int index;
} Query;

typedef struct TrieNode {
    struct TrieNode* children[2];
    int count;
} TrieNode;

TrieNode* triePool;
int trieIndex;

TrieNode* createTrieNode() {
    TrieNode* node = &triePool[trieIndex++];
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (node->children[bit] == NULL) {
            node->children[bit] = createTrieNode();
        }
        node = node->children[bit];
        node->count++;
    }
}

void removeNum(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        node = node->children[bit];
        node->count--;
    }
}

int query(TrieNode* root, int num) {
    TrieNode* node = root;
    int res = 0;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desired = 1 - bit;
        if (node->children[desired] != NULL && node->children[desired]->count > 0) {
            res |= (1 << i);
            node = node->children[desired];
        } else {
            node = node->children[bit];
        }
    }
    return res;
}

int* maxGeneticDifference(int* parents, int parentsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    triePool = (TrieNode*)malloc(MAX_NODES * 40 * sizeof(TrieNode));
    trieIndex = 0;

    TrieNode* root = createTrieNode();

    int n = parentsSize;
    int q = queriesSize;

    int* result = (int*)malloc(q * sizeof(int));
    *returnSize = q;

    int rootNode = -1;
    for (int i = 0; i < n; i++) {
        if (parents[i] == -1) {
            rootNode = i;
            break;
        }
    }

    Query** nodeQueries = (Query**)malloc(n * sizeof(Query*));
    int* queryCount = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < q; i++) {
        int node = queries[i][0];
        queryCount[node]++;
    }
    for (int i = 0; i < n; i++) {
        nodeQueries[i] = (Query*)malloc(queryCount[i] * sizeof(Query));
        queryCount[i] = 0;
    }
    for (int i = 0; i < q; i++) {
        int node = queries[i][0];
        int val = queries[i][1];
        nodeQueries[node][queryCount[node]].node = node;
        nodeQueries[node][queryCount[node]].val = val;
        nodeQueries[node][queryCount[node]].index = i;
        queryCount[node]++;
    }

    int** children = (int**)malloc(n * sizeof(int*));
    int* childCount = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        if (parents[i] != -1) {
            childCount[parents[i]]++;
        }
    }
    for (int i = 0; i < n; i++) {
        children[i] = (int*)malloc(childCount[i] * sizeof(int));
        childCount[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        if (parents[i] != -1) {
            children[parents[i]][childCount[parents[i]]++] = i;
        }
    }

    void dfs(int u) {
        insert(root, u);

        for (int i = 0; i < queryCount[u]; i++) {
            Query qry = nodeQueries[u][i];
            result[qry.index] = query(root, qry.val);
        }

        for (int i = 0; i < childCount[u]; i++) {
            int v = children[u][i];
            dfs(v);
        }

        removeNum(root, u);
    };

    dfs(rootNode);

    for (int i = 0; i < n; i++) {
        free(nodeQueries[i]);
        free(children[i]);
    }
    free(nodeQueries);
    free(children);
    free(childCount);
    free(queryCount);
    free(triePool);

    return result;
}