#include <stdlib.h>
#include <string.h>

#define ll long long

int cmp(const void* a, const void* b) {
    return (*(ll*)a - *(ll*)b);
}

ll max(ll a, ll b) {
    return a > b ? a : b;
}

ll maximumCoins(int* coins, int coinsSize, int k) {
    int n = coinsSize;
    ll* arr = (ll*)malloc(n * sizeof(ll));
    for (int i = 0; i < n; i++) {
        arr[i] = coins[i];
    }

    qsort(arr, n, sizeof(ll), cmp);

    ll* prefix = (ll*)malloc((n + 1) * sizeof(ll));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + arr[i];
    }

    ll res = 0;
    int i = 0;
    while (i < n) {
        int j = i;
        while (j < n && arr[j] == arr[i]) {
            j++;
        }
        int count = j - i;
        ll val = arr[i];

        if (count >= k) {
            res = max(res, val * k);
        } else {
            int needed = k - count;
            if (i >= needed) {
                ll sum = prefix[i] - prefix[i - needed] + val * count;
                res = max(res, sum);
            }
        }
        i = j;
    }

    free(arr);
    free(prefix);
    return res;
}