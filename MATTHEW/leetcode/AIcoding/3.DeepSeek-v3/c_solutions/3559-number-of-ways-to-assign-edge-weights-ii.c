typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} Map;

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(parent, rank, edges[i][0], edges[i][1]);
    }

    Map *countMap = NULL;
    for (int i = 0; i < n; i++) {
        int root = find(parent, i);
        Map *entry;
        HASH_FIND_INT(countMap, &root, entry);
        if (entry == NULL) {
            entry = (Map *)malloc(sizeof(Map));
            entry->key = root;
            entry->val = 1;
            HASH_ADD_INT(countMap, key, entry);
        } else {
            entry->val++;
        }
    }

    long long totalPairs = 0;
    long long sumSizes = 0;
    Map *entry, *tmp;
    HASH_ITER(hh, countMap, entry, tmp) {
        totalPairs += (long long)entry->val * sumSizes;
        sumSizes += entry->val;
        HASH_DEL(countMap, entry);
        free(entry);
    }

    return totalPairs;
}