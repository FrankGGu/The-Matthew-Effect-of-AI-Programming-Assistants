typedef long long ll;

typedef struct {
    int parent;
    ll sum;
} DSU;

int find(DSU* dsu, int x) {
    if (dsu[x].parent != x) {
        dsu[x].parent = find(dsu, dsu[x].parent);
    }
    return dsu[x].parent;
}

void unionSets(DSU* dsu, int x, int y) {
    int rootX = find(dsu, x);
    int rootY = find(dsu, y);
    if (rootX != rootY) {
        if (dsu[rootX].sum < dsu[rootY].sum) {
            dsu[rootX].parent = rootY;
            dsu[rootY].sum += dsu[rootX].sum;
        } else {
            dsu[rootY].parent = rootX;
            dsu[rootX].sum += dsu[rootY].sum;
        }
    }
}

long long* maximumSegmentSum(int* nums, int numsSize, int* removeQueries, int removeQueriesSize, int* returnSize) {
    *returnSize = removeQueriesSize;
    long long* res = (long long*)malloc(removeQueriesSize * sizeof(long long));
    DSU* dsu = (DSU*)malloc(numsSize * sizeof(DSU));
    int* visited = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        dsu[i].parent = -1;
        dsu[i].sum = 0;
    }

    ll maxSum = 0;
    for (int i = removeQueriesSize - 1; i >= 0; i--) {
        res[i] = maxSum;
        int idx = removeQueries[i];
        dsu[idx].parent = idx;
        dsu[idx].sum = nums[idx];

        if (idx > 0 && visited[idx - 1]) {
            unionSets(dsu, idx, idx - 1);
        }
        if (idx < numsSize - 1 && visited[idx + 1]) {
            unionSets(dsu, idx, idx + 1);
        }

        int root = find(dsu, idx);
        if (dsu[root].sum > maxSum) {
            maxSum = dsu[root].sum;
        }
        visited[idx] = 1;
    }

    free(dsu);
    free(visited);
    return res;
}