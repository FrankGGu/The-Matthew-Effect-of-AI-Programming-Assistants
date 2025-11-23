#include <stdlib.h>
#include <string.h>

typedef long long ll;

void merge(ll* arr, int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    ll* L = (ll*)malloc(n1 * sizeof(ll));
    ll* R = (ll*)malloc(n2 * sizeof(ll));

    for (int i = 0; i < n1; i++) L[i] = arr[left + i];
    for (int j = 0; j < n2; j++) R[j] = arr[mid + 1 + j];

    int i = 0, j = 0, k = left;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) arr[k++] = L[i++];
        else arr[k++] = R[j++];
    }

    while (i < n1) arr[k++] = L[i++];
    while (j < n2) arr[k++] = R[j++];

    free(L);
    free(R);
}

int mergeSortCount(ll* arr, int left, int right, ll lower, ll upper) {
    if (left >= right) return 0;

    int mid = left + (right - left) / 2;
    int count = mergeSortCount(arr, left, mid, lower, upper) + 
                mergeSortCount(arr, mid + 1, right, lower, upper);

    int j = mid + 1, k = mid + 1;
    for (int i = left; i <= mid; i++) {
        while (j <= right && arr[j] - arr[i] < lower) j++;
        while (k <= right && arr[k] - arr[i] <= upper) k++;
        count += k - j;
    }

    merge(arr, left, mid, right);
    return count;
}

int countRangeSum(int* nums, int numsSize, int lower, int upper) {
    if (numsSize == 0) return 0;

    ll* prefix = (ll*)malloc((numsSize + 1) * sizeof(ll));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int result = mergeSortCount(prefix, 0, numsSize, lower, upper);
    free(prefix);
    return result;
}