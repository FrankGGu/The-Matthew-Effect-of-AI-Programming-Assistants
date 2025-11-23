typedef struct {
    char* key;
    int index;
    UT_hash_handle hh;
} HashNode;

typedef struct {
    int parent;
    double value;
} UnionFindNode;

int find(int* parent, int x) {
    if (parent[x] != x) {
        int root = find(parent, parent[x]);
        parent[x] = root;
    }
    return parent[x];
}

void unionSet(int* parent, double* weight, int x, int y, double value) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX == rootY) return;
    parent[rootX] = rootY;
    weight[rootX] = weight[y] * value / weight[x];
}

double* calcEquation(char*** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char*** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    HashNode* hash = NULL;
    int count = 0;

    for (int i = 0; i < equationsSize; i++) {
        char* a = equations[i][0];
        char* b = equations[i][1];
        HashNode* node;
        HASH_FIND_STR(hash, a, node);
        if (!node) {
            node = malloc(sizeof(HashNode));
            node->key = a;
            node->index = count++;
            HASH_ADD_STR(hash, key, node);
        }
        HASH_FIND_STR(hash, b, node);
        if (!node) {
            node = malloc(sizeof(HashNode));
            node->key = b;
            node->index = count++;
            HASH_ADD_STR(hash, key, node);
        }
    }

    int* parent = malloc(count * sizeof(int));
    double* weight = malloc(count * sizeof(double));
    for (int i = 0; i < count; i++) {
        parent[i] = i;
        weight[i] = 1.0;
    }

    for (int i = 0; i < equationsSize; i++) {
        char* a = equations[i][0];
        char* b = equations[i][1];
        HashNode* nodeA;
        HashNode* nodeB;
        HASH_FIND_STR(hash, a, nodeA);
        HASH_FIND_STR(hash, b, nodeB);
        unionSet(parent, weight, nodeA->index, nodeB->index, values[i]);
    }

    double* res = malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        char* a = queries[i][0];
        char* b = queries[i][1];
        HashNode* nodeA;
        HashNode* nodeB;
        HASH_FIND_STR(hash, a, nodeA);
        HASH_FIND_STR(hash, b, nodeB);
        if (!nodeA || !nodeB) {
            res[i] = -1.0;
            continue;
        }
        int rootA = find(parent, nodeA->index);
        int rootB = find(parent, nodeB->index);
        if (rootA != rootB) {
            res[i] = -1.0;
        } else {
            res[i] = weight[nodeA->index] / weight[nodeB->index];
        }
    }

    HashNode *current, *tmp;
    HASH_ITER(hh, hash, current, tmp) {
        HASH_DEL(hash, current);
        free(current);
    }
    free(parent);
    free(weight);

    return res;
}