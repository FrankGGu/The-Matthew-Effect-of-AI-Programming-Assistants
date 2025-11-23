int minimumDifference(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int n = numsSize / 2;
    int sumLeft[n + 1][1 << n];
    int sumRight[n + 1][1 << n];
    int leftSize[n + 1], rightSize[n + 1];

    for (int i = 0; i <= n; i++) {
        leftSize[i] = 0;
        rightSize[i] = 0;
    }

    for (int mask = 0; mask < (1 << n); mask++) {
        int cnt = 0;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                cnt++;
                sum += nums[i];
            }
        }
        sumLeft[cnt][leftSize[cnt]++] = sum;

        cnt = 0;
        sum = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                cnt++;
                sum += nums[i + n];
            }
        }
        sumRight[cnt][rightSize[cnt]++] = sum;
    }

    for (int i = 0; i <= n; i++) {
        if (leftSize[i] > 0) {
            qsort(sumLeft[i], leftSize[i], sizeof(int), cmp);
        }
        if (rightSize[i] > 0) {
            qsort(sumRight[i], rightSize[i], sizeof(int), cmp);
        }
    }

    int target = total / 2;
    int res = INT_MAX;

    for (int leftCount = 0; leftCount <= n; leftCount++) {
        int rightCount = n - leftCount;
        int* leftArr = sumLeft[leftCount];
        int* rightArr = sumRight[rightCount];
        int leftLen = leftSize[leftCount];
        int rightLen = rightSize[rightCount];

        int i = 0, j = rightLen - 1;
        while (i < leftLen && j >= 0) {
            int sum = leftArr[i] + rightArr[j];
            int diff = abs(total - 2 * sum);
            if (diff < res) {
                res = diff;
            }
            if (sum < target) {
                i++;
            } else {
                j--;
            }
        }
    }

    return res;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}