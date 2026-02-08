typedef long long ll;

typedef struct Node {
    ll mx00, mx01, mx10, mx11;
} Node;

Node seg[20000 * 4];

Node merge(Node left, Node right) {
    Node res;
    res.mx00 = fmax(left.mx00 + right.mx00, left.mx01 + right.mx10);
    res.mx01 = fmax(left.mx00 + right.mx01, left.mx01 + right.mx11);
    res.mx10 = fmax(left.mx10 + right.mx00, left.mx11 + right.mx10);
    res.mx11 = fmax(left.mx10 + right.mx01, left.mx11 + right.mx11);
    return res;
}

void build(int idx, int l, int r, int* nums) {
    if (l == r) {
        seg[idx].mx00 = 0;
        seg[idx].mx01 = -1e18;
        seg[idx].mx10 = -1e18;
        seg[idx].mx11 = nums[l];
        return;
    }
    int mid = (l + r) / 2;
    build(idx * 2, l, mid, nums);
    build(idx * 2 + 1, mid + 1, r, nums);
    seg[idx] = merge(seg[idx * 2], seg[idx * 2 + 1]);
}

void update(int idx, int l, int r, int pos, int val) {
    if (l == r) {
        seg[idx].mx00 = 0;
        seg[idx].mx01 = -1e18;
        seg[idx].mx10 = -1e18;
        seg[idx].mx11 = val;
        return;
    }
    int mid = (l + r) / 2;
    if (pos <= mid) update(idx * 2, l, mid, pos, val);
    else update(idx * 2 + 1, mid + 1, r, pos, val);
    seg[idx] = merge(seg[idx * 2], seg[idx * 2 + 1]);
}

int maximumSumSubsequence(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize) {
    build(1, 0, numsSize - 1, nums);
    ll res = 0;
    for (int i = 0; i < queriesSize; i++) {
        int pos = queries[i][0];
        int val = queries[i][1];
        update(1, 0, numsSize - 1, pos, val);
        ll ans = fmax(seg[1].mx00, fmax(seg[1].mx01, fmax(seg[1].mx10, seg[1].mx11)));
        res = (res + ans) % 1000000007;
    }
    return res;
}