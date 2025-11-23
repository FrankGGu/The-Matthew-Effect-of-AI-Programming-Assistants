typedef long long ll;

typedef struct {
    ll *tree;
    int size;
} FenwickTree;

void initFenwick(FenwickTree *ft, int n) {
    ft->size = n;
    ft->tree = (ll *)calloc(n + 1, sizeof(ll));
}

void update(FenwickTree *ft, int index, ll delta) {
    while (index <= ft->size) {
        ft->tree[index] = (ft->tree[index] + delta) % 1000000007;
        index += index & -index;
    }
}

ll query(FenwickTree *ft, int index) {
    ll sum = 0;
    while (index > 0) {
        sum = (sum + ft->tree[index]) % 1000000007;
        index -= index & -index;
    }
    return sum;
}

ll rangeSum(FenwickTree *ft, int l, int r) {
    if (l > r) return 0;
    return (query(ft, r) - query(ft, l - 1) + 1000000007) % 1000000007;
}

int sumCounts(int* nums, int numsSize) {
    const int MOD = 1000000007;
    int n = numsSize;

    int *sorted = (int *)malloc(n * sizeof(int));
    memcpy(sorted, nums, n * sizeof(int));
    qsort(sorted, n, sizeof(int), (int(*)(const void*, const void*))strcmp);

    int *compressed = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        compressed[i] = lower_bound(sorted, sorted + n, nums[i]) - sorted + 1;
    }

    int *prev = (int *)calloc(n + 1, sizeof(int));
    int *last = (int *)calloc(n + 1, sizeof(int));

    for (int i = 0; i < n; i++) {
        prev[i] = last[compressed[i]];
        last[compressed[i]] = i + 1;
    }

    FenwickTree ft1, ft2;
    initFenwick(&ft1, n);
    initFenwick(&ft2, n);

    ll res = 0;
    ll sumDp = 0;

    for (int i = 1; i <= n; i++) {
        int p = prev[i - 1];

        ll add1 = (rangeSum(&ft1, p + 1, i - 1) * 2 % MOD + (i - p)) % MOD;
        ll add2 = rangeSum(&ft2, p + 1, i - 1);

        ll dp = (add1 + add2) % MOD;
        sumDp = (sumDp + dp) % MOD;
        res = (res + sumDp) % MOD;

        update(&ft1, i, dp);
        update(&ft2, i, (ll)(i - 1) * dp % MOD);

        if (p > 0) {
            update(&ft1, p, -dp);
            update(&ft2, p, -(ll)(p - 1) * dp % MOD + MOD);
        }
    }

    free(sorted);
    free(compressed);
    free(prev);
    free(last);
    free(ft1.tree);
    free(ft2.tree);

    return res;
}