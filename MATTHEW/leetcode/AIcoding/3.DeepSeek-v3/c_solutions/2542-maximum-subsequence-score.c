typedef struct {
    int num1;
    int num2;
} Pair;

int cmp(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    return pb->num2 - pa->num2;
}

long long maxScore(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    Pair* pairs = (Pair*)malloc(nums1Size * sizeof(Pair));
    for (int i = 0; i < nums1Size; i++) {
        pairs[i].num1 = nums1[i];
        pairs[i].num2 = nums2[i];
    }

    qsort(pairs, nums1Size, sizeof(Pair), cmp);

    long long* minHeap = (long long*)malloc(k * sizeof(long long));
    long long sum = 0;
    for (int i = 0; i < k; i++) {
        minHeap[i] = pairs[i].num1;
        sum += pairs[i].num1;
    }

    for (int i = k / 2 - 1; i >= 0; i--) {
        long long parent = i;
        long long child = 2 * parent + 1;
        while (child < k) {
            if (child + 1 < k && minHeap[child] > minHeap[child + 1]) {
                child++;
            }
            if (minHeap[parent] > minHeap[child]) {
                long long temp = minHeap[parent];
                minHeap[parent] = minHeap[child];
                minHeap[child] = temp;
                parent = child;
                child = 2 * parent + 1;
            } else {
                break;
            }
        }
    }

    long long res = sum * pairs[k - 1].num2;

    for (int i = k; i < nums1Size; i++) {
        if (pairs[i].num1 > minHeap[0]) {
            sum = sum - minHeap[0] + pairs[i].num1;
            minHeap[0] = pairs[i].num1;

            long long parent = 0;
            while (1) {
                long long left = 2 * parent + 1;
                long long right = 2 * parent + 2;
                long long smallest = parent;

                if (left < k && minHeap[left] < minHeap[smallest]) {
                    smallest = left;
                }
                if (right < k && minHeap[right] < minHeap[smallest]) {
                    smallest = right;
                }
                if (smallest != parent) {
                    long long temp = minHeap[parent];
                    minHeap[parent] = minHeap[smallest];
                    minHeap[smallest] = temp;
                    parent = smallest;
                } else {
                    break;
                }
            }

            long long score = sum * pairs[i].num2;
            if (score > res) {
                res = score;
            }
        }
    }

    free(pairs);
    free(minHeap);
    return res;
}