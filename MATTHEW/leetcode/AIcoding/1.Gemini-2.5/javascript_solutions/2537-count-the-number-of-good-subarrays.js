var countGoodSubarrays = function(nums, k) {
    let ans = 0;
    let left = 0;
    let currentPairs = 0;
    const freq = new Map();
    const n = nums.length;

    for (let right = 0; right < n; right++) {
        const numR = nums[right];

        // When adding nums[right], it forms new pairs with existing occurrences of numR in the window.
        // If numR has appeared 'x' times before, it forms 'x' new pairs.
        currentPairs += freq.get(numR) || 0;
        freq.set(numR, (freq.get(numR) || 0) + 1);

        // While the current window [left, right] has at least k pairs:
        while (currentPairs >= k) {
            // If [left, right] is a good subarray, then any subarray [left, right], [left, right+1], ..., [left, n-1]
            // is also good because adding elements to the right can only increase or maintain the number of pairs.
            // So, there are (n - right) good subarrays starting at 'left' and ending at or after 'right'.
            ans += (n - right);

            // Shrink the window from the left.
            const numL = nums[left];

            // When removing nums[left], it stops forming pairs with other occurrences of numL.
            // If numL had 'x' occurrences, it formed 'x-1' pairs with them. These 'x-1' pairs are now lost.
            currentPairs -= (freq.get(numL) - 1);
            freq.set(numL, freq.get(numL) - 1);
            left++;
        }
    }

    return ans;
};