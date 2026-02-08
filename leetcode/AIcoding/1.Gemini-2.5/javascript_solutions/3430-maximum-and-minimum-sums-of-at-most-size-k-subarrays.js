var maximumAndMinimumSums = function(nums, k) {
    const n = nums.length;

    // Calculate prefix sums. prefixSum[i] stores the sum of nums[0...i-1].
    // prefixSum[0] = 0
    // prefixSum[i] = nums[0] + ... + nums[i-1] for i > 0
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let maxSum = -Infinity;
    let minSum = Infinity;

    // Deque for finding the minimum prefix sum (to maximize subarray sum)
    // Stores indices `idx` such that `prefixSum[idx]` values are in increasing order.
    const dqMinP = []; 

    // Deque for finding the maximum prefix sum (to minimize subarray sum)
    // Stores indices `idx` such that `prefixSum[idx]` values are in decreasing order.
    const dqMaxP = [];

    // Initialize deques with index 0, representing prefixSum[0] = 0.
    // This allows considering subarrays starting from index 0.
    dqMinP.push(0);
    dqMaxP.push(0);

    // Iterate through all possible right endpoints 'r' of subarrays.
    // 'r' goes from 0 to n-1.
    // The current subarray ends at nums[r].
    // Its sum is prefixSum[r+1] - prefixSum[l], where 'l' is the starting index of the subarray.
    // The prefixSum index for the current right endpoint is `r+1`.
    for (let r = 0; r < n; r++) {
        const currentPVal = prefixSum[r + 1];

        // The starting index 'l' for a subarray nums[l...r] must satisfy 1 <= r - l + 1 <= k.
        // This implies l >= r - k + 1.
        // Also, l must be at least 0. So, l >= max(0, r - k + 1).
        // The indices 'idx' stored in the deques represent these 'l' values.
        // So, 'idx' must be in the range [max(0, r - k + 1), r].
        const windowStartPIdx = Math.max(0, r - k + 1);

        // Remove indices from the front of dqMinP that are no longer within the valid window [windowStartPIdx, r].
        while (dqMinP.length > 0 && dqMinP[0] < windowStartPIdx) {
            dqMinP.shift();
        }
        // Remove indices from the front of dqMaxP that are no longer within the valid window [windowStartPIdx, r].
        while (dqMaxP.length > 0 && dqMaxP[0] < windowStartPIdx) {
            dqMaxP.shift();
        }

        // Calculate maximum subarray sum ending at 'r': currentPVal - min(prefixSum[l])
        maxSum = Math.max(maxSum, currentPVal - prefixSum[dqMinP[0]]);

        // Calculate minimum subarray sum ending at 'r': currentPVal - max(prefixSum[l])
        minSum = Math.min(minSum, currentPVal - prefixSum[dqMaxP[0]]);

        // Add the current prefix sum index (r+1) to the deques.
        // This (r+1) index will serve as a potential 'l' (starting index for prefixSum[l])
        // for subarrays that end at future 'r'' values.

        // Maintain dqMinP (monotonic increasing prefixSum values)
        while (dqMinP.length > 0 && prefixSum[dqMinP[dqMinP.length - 1]] >= currentPVal) {
            dqMinP.pop();
        }
        dqMinP.push(r + 1);

        // Maintain dqMaxP (monotonic decreasing prefixSum values)
        while (dqMaxP.length > 0 && prefixSum[dqMaxP[dqMaxP.length - 1]] <= currentPVal) {
            dqMaxP.pop();
        }
        dqMaxP.push(r + 1);
    }

    return [maxSum, minSum];
};