var maxSumDivisibleByK = function(nums, k) {
    let n = nums.length;

    // dp[r] stores the minimum prefix sum encountered so far
    // such that its index (length of prefix) modulo k is r.
    // prefixSum[p] is sum of nums[0...p-1]. The index is p.
    // We are looking for prefixSum[j+1] - prefixSum[i]
    // where (j+1 - i) % k == 0, which means (j+1) % k == i % k.
    let dp = new Array(k).fill(Infinity);

    // Initialize dp[0] to 0, representing an empty prefix sum (before nums[0]),
    // which has length 0, and 0 % k == 0.
    dp[0] = 0;

    // Initialize maxSum to negative infinity, as sums can be negative.
    let maxSum = -Infinity;

    let currentPrefixSum = 0;

    for (let j = 0; j < n; j++) {
        currentPrefixSum += nums[j];

        // The current prefix sum corresponds to prefixSum[j+1].
        // Its "index" is j+1.
        let currentPrefixIndexRemainder = (j + 1) % k;

        // We need to find a previous prefix sum prefixSum[i]
        // such that i % k == currentPrefixIndexRemainder.
        // If such a prefixSum[i] exists (i.e., dp[currentPrefixIndexRemainder] is not Infinity),
        // then the subarray sum (currentPrefixSum - dp[currentPrefixIndexRemainder])
        // has a length (j+1 - i) divisible by k.
        if (dp[currentPrefixIndexRemainder] !== Infinity) {
            maxSum = Math.max(maxSum, currentPrefixSum - dp[currentPrefixIndexRemainder]);
        }

        // Update dp[currentPrefixIndexRemainder] with the minimum prefix sum
        // encountered so far for this remainder.
        dp[currentPrefixIndexRemainder] = Math.min(dp[currentPrefixIndexRemainder], currentPrefixSum);
    }

    return maxSum;
};