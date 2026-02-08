#include <stdlib.h>
#include <string.h>

typedef long long ll;

int cmp(const void* a, const void* b) {
    return *(ll*)a - *(ll*)b;
}

long long minimumDifference(int* nums, int numsSize) {
    int n = numsSize / 3;

    ll* prefix = (ll*)malloc((2 * n + 1) * sizeof(ll));
    ll* suffix = (ll*)malloc((2 * n + 1) * sizeof(ll));
    ll* maxHeap = (ll*)malloc((n + 1) * sizeof(ll));
    ll* minHeap = (ll*)malloc((n + 1) * sizeof(ll));

    ll sum = 0;
    int size = 0;

    for (int i = 0; i < n; i++) {
        sum += nums[i];
        maxHeap[size++] = nums[i];
    }

    for (int i = n; i <= 2 * n; i++) {
        if (i == n) {
            qsort(maxHeap, n, sizeof(ll), cmp);
        } else {
            if (nums[i - 1] < maxHeap[n - 1]) {
                sum = sum - maxHeap[n - 1] + nums[i - 1];
                maxHeap[n - 1] = nums[i - 1];
                qsort(maxHeap, n, sizeof(ll), cmp);
            }
        }
        prefix[i] = sum;
    }

    sum = 0;
    size = 0;

    for (int i = 3 * n - 1; i >= 2 * n; i--) {
        sum += nums[i];
        minHeap[size++] = nums[i];
    }

    for (int i = 2 * n; i >= n; i--) {
        if (i == 2 * n) {
            qsort(minHeap, n, sizeof(ll), cmp);
        } else {
            if (nums[i] > minHeap[0]) {
                sum = sum - minHeap[0] + nums[i];
                minHeap[0] = nums[i];
                qsort(minHeap, n, sizeof(ll), cmp);
            }
        }
        suffix[i] = sum;
    }

    ll res = 1e18;
    for (int i = n; i <= 2 * n; i++) {
        ll diff = prefix[i] - suffix[i];
        if (diff < res) res = diff;
    }

    free(prefix);
    free(suffix);
    free(maxHeap);
    free(minHeap);

    return res;
}