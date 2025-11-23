typedef long long ll;

typedef struct {
    ll val;
    int idx;
} Pair;

int cmp(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    if (pa->val != pb->val) {
        return pa->val > pb->val ? -1 : 1;
    }
    return pa->idx - pb->idx;
}

long long maximumSum(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    int n = nums1Size;
    Pair* pairs = (Pair*)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        pairs[i].val = nums2[i];
        pairs[i].idx = i;
    }
    qsort(pairs, n, sizeof(Pair), cmp);

    ll* minHeap = (ll*)malloc(k * sizeof(ll));
    int heapSize = 0;
    ll sum = 0;
    ll res = 0;

    for (int i = 0; i < n; i++) {
        int idx = pairs[i].idx;
        ll num1 = nums1[idx];
        ll num2 = nums2[idx];

        if (heapSize < k) {
            sum += num1;
            minHeap[heapSize++] = num1;
            if (heapSize == k) {
                res = sum * num2;
            }
            if (heapSize > 1 && minHeap[heapSize-1] < minHeap[0]) {
                ll temp = minHeap[0];
                minHeap[0] = minHeap[heapSize-1];
                minHeap[heapSize-1] = temp;
            }
        } else {
            if (num1 > minHeap[0]) {
                sum = sum - minHeap[0] + num1;
                minHeap[0] = num1;
                int j = 0;
                while (1) {
                    int left = 2*j+1;
                    int right = 2*j+2;
                    int smallest = j;
                    if (left < k && minHeap[left] < minHeap[smallest]) smallest = left;
                    if (right < k && minHeap[right] < minHeap[smallest]) smallest = right;
                    if (smallest == j) break;
                    ll temp = minHeap[j];
                    minHeap[j] = minHeap[smallest];
                    minHeap[smallest] = temp;
                    j = smallest;
                }
            }
            res = (res > sum * num2) ? res : sum * num2;
        }
    }

    free(pairs);
    free(minHeap);
    return res;
}