int threeSumMulti(int* A, int ASize, int target) {
    long count = 0;
    int mod = 1e9 + 7;
    qsort(A, ASize, sizeof(int), cmp);
    for (int i = 0; i < ASize; i++) {
        for (int j = i; j < ASize; j++) {
            int k = target - A[i] - A[j];
            if (k < A[j]) break;
            int left = j, right = ASize - 1;
            while (left <= right) {
                if (A[left] < k) {
                    left++;
                } else if (A[left] > k) {
                    right--;
                } else {
                    long lCount = 1, rCount = 1;
                    while (left < ASize && A[left] == A[left + 1]) {
                        lCount++;
                        left++;
                    }
                    while (right > j && A[right] == A[right - 1]) {
                        rCount++;
                        right--;
                    }
                    if (left == right) {
                        count = (count + lCount * (lCount - 1) / 2) % mod;
                    } else {
                        count = (count + lCount * rCount) % mod;
                    }
                    left++;
                    right--;
                }
            }
        }
    }
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}