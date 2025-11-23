#include <stdlib.h>
#include <string.h>

typedef long long ll;

int cmp(const void* a, const void* b) {
    ll x = *(ll*)a;
    ll y = *(ll*)b;
    if (x > y) return 1;
    if (x < y) return -1;
    return 0;
}

long long kSum(int* nums, int numsSize, int k) {
    ll sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) sum += nums[i];
    }

    ll* abs_nums = (ll*)malloc(numsSize * sizeof(ll));
    for (int i = 0; i < numsSize; i++) {
        abs_nums[i] = llabs((ll)nums[i]);
    }

    qsort(abs_nums, numsSize, sizeof(ll), cmp);

    ll* arr = (ll*)malloc(k * sizeof(ll));
    int arr_size = 1;
    arr[0] = sum;

    for (int i = 0; i < numsSize; i++) {
        if (arr_size >= k) break;
        ll x = abs_nums[i];
        int j = arr_size;
        for (int p = 0; p < arr_size; p++) {
            if (arr_size + p >= k) break;
            ll val = arr[p] - x;
            arr[j++] = val;
        }
        qsort(arr, j, sizeof(ll), cmp);
        arr_size = j > k ? k : j;
    }

    free(abs_nums);
    ll result = arr[k - 1];
    free(arr);
    return result;
}