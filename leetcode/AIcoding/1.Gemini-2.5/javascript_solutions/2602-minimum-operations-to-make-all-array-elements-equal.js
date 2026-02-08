var minOperations = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    // Calculate prefix sums
    // prefixSums[i] will store the sum of nums[0]...nums[i-1]
    const prefixSums = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    const result = [];

    // Binary search function to find the index of the first element strictly greater than target.
    // This index also represents the count of elements in the sorted array that are less than or equal to target.
    const upper_bound = (arr, target) => {
        let low = 0;
        let high = arr.length; 
        let ans = arr.length; // Default to arr.length if all elements are <= target

        while (low < high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                ans = mid; 
                high = mid;
            }
        }
        return ans;
    };

    for (const q of queries) {
        // k is the count of elements in nums that are less than or equal to q.
        // It's also the index of the first element strictly greater than q.
        const k = upper_bound(nums, q);

        // Calculate operations for elements <= q
        // These elements need to be incremented to q.
        // Sum of (q - nums[i]) for i from 0 to k-1
        // = (k * q) - sum(nums[0]...nums[k-1])
        const leftSum = prefixSums[k];
        const leftCount = k;
        const opsLeft = leftCount * q - leftSum;

        // Calculate operations for elements > q
        // These elements need to be decremented to q.
        // Sum of (nums[i] - q) for i from k to n-1
        // = sum(nums[k]...nums[n-1]) - ((n - k) * q)
        const rightSum = prefixSums[n] - prefixSums[k];
        const rightCount = n - k;
        const opsRight = rightSum - rightCount * q;

        result.push(opsLeft + opsRight);
    }

    return result;
};