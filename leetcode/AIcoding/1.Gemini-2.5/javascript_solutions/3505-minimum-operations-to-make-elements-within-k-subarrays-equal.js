var minOperations = function(nums, k) {
    let n = nums.length;
    let totalOperations = 0;

    // If k is 1, no operations are needed as each element is a group of one.
    // If k is greater than or equal to n, no operations are needed as there are no elements
    // at indices i and i+k that need to be made equal.
    // However, the loop structure naturally handles these cases, resulting in 0 operations.

    // Iterate through each of the k groups.
    // Group `i` consists of elements at indices `i`, `i+k`, `i+2k`, ..., `i+m*k` where `i+m*k < n`.
    for (let i = 0; i < k; i++) {
        let groupElements = [];
        for (let j = i; j < n; j += k) {
            groupElements.push(nums[j]);
        }

        // If a group is empty (e.g., when k > n and i >= n), no operations are needed for it.
        if (groupElements.length === 0) {
            continue;
        }

        // To minimize the sum of absolute differences to a target value,
        // the target value should be the median of the group's elements.
        groupElements.sort((a, b) => a - b);

        let median;
        let len = groupElements.length;
        // For an odd number of elements, the median is the middle element.
        // For an even number of elements, any value between the two middle elements (inclusive)
        // minimizes the sum of absolute differences. We can pick either of the two middle elements.
        // Using Math.floor(len / 2) will pick the lower median for odd length,
        // and the upper of the two middle elements for even length. Both are valid choices.
        median = groupElements[Math.floor((len - 1) / 2)]; // This picks the lower median for even length.

        // Calculate operations for this group by summing absolute differences to the median.
        for (let val of groupElements) {
            totalOperations += Math.abs(val - median);
        }
    }

    return totalOperations;
};