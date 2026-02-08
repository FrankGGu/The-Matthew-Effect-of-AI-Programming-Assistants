int waysToSplit(int* nums, int numsSize) {
    int* prefixSum = (int*)malloc((numsSize + 1) * sizeof(int));
    long long total = 0, count = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
        prefixSum[i + 1] = total;
    }
    for (int i = 1; i < numsSize - 1; i++) {
        long long left = prefixSum[i];
        long long rightMin = total - prefixSum[i + 1];
        long long rightMax = total - prefixSum[numsSize - 1];
        if (left > rightMax) break;
        while (count < numsSize - 1 && prefixSum[count + 1] - prefixSum[i] < left) count++;
        long long low = count, high = numsSize - 2;
        while (low < high) {
            int mid = (low + high + 1) / 2;
            if (prefixSum[mid + 1] - prefixSum[i] >= left) high = mid - 1;
            else low = mid;
        }
        count = low;
        while (count < numsSize - 1 && prefixSum[count + 1] - prefixSum[i] <= rightMin) count++;
        long long rightCount = count - (low + 1);
        count += rightCount;
    }
    free(prefixSum);
    return count % 1000000007;
}