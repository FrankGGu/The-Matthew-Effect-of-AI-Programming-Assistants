var subarraysDivByK = function(nums, k) {
    let count = 0;
    let currentSum = 0;
    // freq array to store the count of each remainder encountered so far
    // freq[r] will store how many times a prefix sum modulo k resulted in r
    let freq = new Array(k).fill(0);

    // The prefix sum before any elements is 0.
    // 0 % k = 0, so we initialize freq[0] to 1 to account for subarrays
    // that start from index 0 and have a sum divisible by k.
    freq[0] = 1;

    for (let num of nums) {
        currentSum += num;
        // Calculate the remainder.
        // The expression (currentSum % k + k) % k ensures the remainder is always non-negative,
        // even if currentSum % k is negative (which can happen in JavaScript for negative numbers).
        let remainder = (currentSum % k + k) % k;

        // If we have seen this remainder before, it means that the difference
        // between the current prefix sum and those previous prefix sums is
        // divisible by k. Each such previous occurrence forms a valid subarray.
        count += freq[remainder];

        // Increment the count for the current remainder
        freq[remainder]++;
    }

    return count;
};