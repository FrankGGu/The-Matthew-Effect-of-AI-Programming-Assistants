typedef struct {
    int* tree;
    int size;
} SegmentTree;

SegmentTree* createSegmentTree(int n) {
    SegmentTree* segTree = (SegmentTree*)malloc(sizeof(SegmentTree));
    segTree->size = n;
    segTree->tree = (int*)calloc(4 * n, sizeof(int));
    return segTree;
}

void update(SegmentTree* segTree, int idx, int val, int node, int left, int right) {
    if (left == right) {
        segTree->tree[node] = val;
        return;
    }
    int mid = (left + right) / 2;
    if (idx <= mid) {
        update(segTree, idx, val, 2 * node, left, mid);
    } else {
        update(segTree, idx, val, 2 * node + 1, mid + 1, right);
    }
    segTree->tree[node] = fmax(segTree->tree[2 * node], segTree->tree[2 * node + 1]);
}

int query(SegmentTree* segTree, int l, int r, int node, int left, int right) {
    if (l > right || r < left) return 0;
    if (l <= left && right <= r) return segTree->tree[node];
    int mid = (left + right) / 2;
    int leftMax = query(segTree, l, r, 2 * node, left, mid);
    int rightMax = query(segTree, l, r, 2 * node + 1, mid + 1, right);
    return fmax(leftMax, rightMax);
}

bool* getResults(int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = 50000;
    SegmentTree* segTree = createSegmentTree(n);
    bool* obstacles = (bool*)calloc(n + 2, sizeof(bool));
    obstacles[0] = true;
    obstacles[n] = true;
    update(segTree, 0, 0, 1, 0, n);
    update(segTree, n, n, 1, 0, n);

    int resultCount = 0;
    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 1) {
            resultCount++;
        }
    }

    bool* result = (bool*)malloc(resultCount * sizeof(bool));
    int resultIdx = 0;

    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 1) {
            int x = queries[i][1];
            int size = queries[i][2];
            int left = 0, right = x;
            while (left <= right) {
                int mid = (left + right) / 2;
                int maxGap = query(segTree, mid, x, 1, 0, n);
                if (maxGap >= size) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            int start = right;
            if (start < 0) start = 0;
            int maxGap = query(segTree, start, x, 1, 0, n);
            result[resultIdx++] = (maxGap >= size);
        } else {
            int x = queries[i][1];
            obstacles[x] = true;
            update(segTree, x, x, 1, 0, n);
        }
    }

    free(segTree->tree);
    free(segTree);
    free(obstacles);
    *returnSize = resultCount;
    return result;
}