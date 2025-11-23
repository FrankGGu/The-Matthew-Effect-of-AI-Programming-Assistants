var waysToSplit = function(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const totalSum = prefixSum[n];
    let ans = 0;
    let ptr1 = 1; // Represents the index for the second split point (j)
    let ptr2 = 1; // Represents the index for the second split point (j)

    // i is the index for the first split point.
    // left subarray: nums[0...i-1], sum = prefixSum[i]
    // mid subarray: nums[i...j-1], sum = prefixSum[j] - prefixSum[i]
    // right subarray: nums[j...n-1], sum = prefixSum[n] - prefixSum[j]
    // i ranges from 1 to n-2 (inclusive)
    // j ranges from i+1 to n-1 (inclusive)
    for (let i = 1; i <= n - 2; i++) {
        const sumLeft = prefixSum[i];

        // ptr1 finds the minimum j such that sum(mid) >= sum(left)
        // i.e., prefixSum[j] - sumLeft >= sumLeft  =>  prefixSum[j] >= 2 * sumLeft
        // ptr1 must be at least i+1 (mid subarray must be non-empty)
        ptr1 = Math.max(ptr1, i + 1);
        while (ptr1 < n && prefixSum[ptr1] < 2 * sumLeft) {
            ptr1++;
        }

        // ptr2 finds the minimum j such that sum(mid) > sum(right)
        // i.e., prefixSum[j] - sumLeft > totalSum - prefixSum[j]  =>  2 * prefixSum[j] > totalSum + sumLeft
        // ptr2 must be at least i+1 (mid subarray must be non-empty)
        ptr2 = Math.max(ptr2, i + 1);
        while (ptr2 < n && 2 * prefixSum[ptr2] <= totalSum + sumLeft) {
            ptr2++;
        }

        // After the loops:
        // ptr1 points to the first valid j (where sum(mid) >= sum(left))
        // ptr2 points to the first j where sum(mid) > sum(right)
        // All j in the range [ptr1, ptr2 - 1] satisfy both conditions:
        // sum(left) <= sum(mid) AND sum(mid) <= sum(right)
        // We also need to ensure j <= n-1 (right subarray must be non-empty),
        // which is handled by ptr1 < n and ptr2 < n conditions in while loops.
        ans += Math.max(0, ptr2 - ptr1);
    }

    return ans;
};