typedef long long ll;

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

ll min(ll a, ll b) {
    return a < b ? a : b;
}

long long minCost(int* basket1, int basket1Size, int* basket2, int basket2Size) {
    int n = basket1Size;
    int* all = (int*)malloc(2 * n * sizeof(int));
    for (int i = 0; i < n; i++) {
        all[i] = basket1[i];
        all[i + n] = basket2[i];
    }
    qsort(all, 2 * n, sizeof(int), cmp);

    int min_val = all[0];

    int* cnt1 = (int*)calloc(200001, sizeof(int));
    int* cnt2 = (int*)calloc(200001, sizeof(int));

    for (int i = 0; i < n; i++) {
        cnt1[basket1[i]]++;
        cnt2[basket2[i]]++;
    }

    int* swap1 = (int*)malloc(n * sizeof(int));
    int* swap2 = (int*)malloc(n * sizeof(int));
    int idx1 = 0, idx2 = 0;

    for (int i = 1; i <= 200000; i++) {
        int total = cnt1[i] + cnt2[i];
        if (total % 2 != 0) return -1;
        int target = total / 2;
        if (cnt1[i] > target) {
            int diff = cnt1[i] - target;
            for (int j = 0; j < diff; j++) {
                swap1[idx1++] = i;
            }
        } else if (cnt2[i] > target) {
            int diff = cnt2[i] - target;
            for (int j = 0; j < diff; j++) {
                swap2[idx2++] = i;
            }
        }
    }

    if (idx1 != idx2) return -1;

    qsort(swap1, idx1, sizeof(int), cmp);
    qsort(swap2, idx2, sizeof(int), cmp);

    ll res = 0;
    for (int i = 0; i < idx1; i++) {
        res += min(min(swap1[i], swap2[idx1 - 1 - i]), 2 * min_val);
    }

    free(all);
    free(cnt1);
    free(cnt2);
    free(swap1);
    free(swap2);

    return res;
}