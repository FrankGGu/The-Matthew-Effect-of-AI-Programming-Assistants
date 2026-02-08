var shortestSubarray = function(nums, k) {
    const n = nums.length;
    const prefixSums = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    let minLen = Infinity;
    const deque = []; // Stores indices

    for (let i = 0; i <= n; i++) {
        // Condition 1: prefixSums[i] - prefixSums[deque[0]] >= k
        // We found a subarray with sum at least k.
        // Since deque[0] is the smallest index, i - deque[0] is the current shortest length for this prefixSums[i].
        // We remove deque[0] because it's no longer needed for future calculations (any future prefixSums[j] where j > i
        // would result in a longer or equal length with deque[0] than with a later index).
        while (deque.length > 0 && prefixSums[i] - prefixSums[deque[0]] >= k) {
            minLen = Math.min(minLen, i - deque.shift());
        }

        // Condition 2: Maintain monotonic increasing prefix sums in the deque.
        // If prefixSums[i] is less than or equal to prefixSums[deque.back()],
        // then deque.back() is a worse candidate for future calculations:
        // - It has a larger index than i.
        // - It has a greater or equal prefix sum than prefixSums[i].
        // So, for any future prefixSums[j] (j > i), prefixSums[j] - prefixSums[i] will be greater than or equal to
        // prefixSums[j] - prefixSums[deque.back()] AND i is a smaller index.
        // Thus, deque.back() can be removed.
        while (deque.length > 0 && prefixSums[i] <= prefixSums[deque[deque.length - 1]]) {
            deque.pop();
        }

        // Add current index to the deque.
        deque.push(i);
    }

    return minLen === Infinity ? -1 : minLen;
};