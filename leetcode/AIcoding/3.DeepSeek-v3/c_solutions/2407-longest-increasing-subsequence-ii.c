#define max(a, b) ((a) > (b) ? (a) : (b))

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

void update(SegmentTree* segTree, int idx, int l, int r, int pos, int val) {
    if (l == r) {
        segTree->tree[idx] = val;
        return;
    }
    int mid = (l + r) / 2;
    if (pos <= mid) {
        update(segTree, idx * 2, l, mid, pos, val);
    } else {
        update(segTree, idx * 2 + 1, mid + 1, r, pos, val);
    }
    segTree->tree[idx] = max(segTree->tree[idx * 2], segTree->tree[idx * 2 + 1]);
}

int query(SegmentTree* segTree, int idx, int l, int r, int ql, int qr) {
    if (ql > r || qr < l) return 0;
    if (ql <= l && r <= qr) return segTree->tree[idx];
    int mid = (l + r) / 2;
    return max(query(segTree, idx * 2, l, mid, ql, qr),
               query(segTree, idx * 2 + 1, mid + 1, r, ql, qr));
}

void freeSegmentTree(SegmentTree* segTree) {
    free(segTree->tree);
    free(segTree);
}

int longestIncreasingSubsequence(int* nums, int numsSize, int k) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        max_val = max(max_val, nums[i]);
    }

    SegmentTree* segTree = createSegmentTree(max_val + 1);
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        int left = max(1, nums[i] - k);
        int right = nums[i] - 1;
        int max_len = 0;

        if (left <= right) {
            max_len = query(segTree, 1, 1, max_val, left, right);
        }

        int current = max_len + 1;
        result = max(result, current);
        update(segTree, 1, 1, max_val, nums[i], current);
    }

    freeSegmentTree(segTree);
    return result;
}