typedef long long ll;

typedef struct {
    int l, r;
    ll sum;
    int lazy;
} SegmentTree;

void build(SegmentTree *tree, int idx, int l, int r, int *nums) {
    tree[idx].l = l;
    tree[idx].r = r;
    tree[idx].lazy = 0;
    if (l == r) {
        tree[idx].sum = nums[l];
        return;
    }
    int mid = (l + r) / 2;
    build(tree, idx * 2, l, mid, nums);
    build(tree, idx * 2 + 1, mid + 1, r, nums);
    tree[idx].sum = tree[idx * 2].sum + tree[idx * 2 + 1].sum;
}

void pushDown(SegmentTree *tree, int idx) {
    if (tree[idx].lazy) {
        int mid = (tree[idx].l + tree[idx].r) / 2;
        tree[idx * 2].sum = (mid - tree[idx].l + 1) - tree[idx * 2].sum;
        tree[idx * 2 + 1].sum = (tree[idx].r - mid) - tree[idx * 2 + 1].sum;
        tree[idx * 2].lazy ^= 1;
        tree[idx * 2 + 1].lazy ^= 1;
        tree[idx].lazy = 0;
    }
}

void update(SegmentTree *tree, int idx, int l, int r) {
    if (tree[idx].l >= l && tree[idx].r <= r) {
        tree[idx].sum = (tree[idx].r - tree[idx].l + 1) - tree[idx].sum;
        tree[idx].lazy ^= 1;
        return;
    }
    pushDown(tree, idx);
    int mid = (tree[idx].l + tree[idx].r) / 2;
    if (l <= mid) update(tree, idx * 2, l, r);
    if (r > mid) update(tree, idx * 2 + 1, l, r);
    tree[idx].sum = tree[idx * 2].sum + tree[idx * 2 + 1].sum;
}

long long* handleQuery(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = nums1Size;
    SegmentTree *tree = (SegmentTree *)malloc(4 * n * sizeof(SegmentTree));
    build(tree, 1, 0, n - 1, nums1);

    ll sum2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        sum2 += nums2[i];
    }

    int cnt = 0;
    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 3) cnt++;
    }

    ll *res = (ll *)malloc(cnt * sizeof(ll));
    int idx = 0;

    for (int i = 0; i < queriesSize; i++) {
        int type = queries[i][0];
        if (type == 1) {
            int l = queries[i][1], r = queries[i][2];
            update(tree, 1, l, r);
        } else if (type == 2) {
            int p = queries[i][1];
            sum2 += (ll)tree[1].sum * p;
        } else {
            res[idx++] = sum2;
        }
    }

    free(tree);
    *returnSize = cnt;
    return res;
}