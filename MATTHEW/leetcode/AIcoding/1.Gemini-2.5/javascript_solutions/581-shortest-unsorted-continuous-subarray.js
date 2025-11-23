var findUnsortedSubarray = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    let left = -1;
    let right = -1;

    // Pass 1: Find the rightmost boundary of the unsorted subarray.
    // Iterate from left to right, maintaining the maximum element encountered so far.
    // If the current element is less than the maximum seen, it means this element
    // is out of place and needs to be part of the sorted subarray.
    // This index is a candidate for the right boundary.
    let maxSeen = -Infinity;
    for (let i = 0; i < n; i++) {
        if (nums[i] < maxSeen) {
            right = i;
        } else {
            maxSeen = nums[i];
        }
    }

    // Pass 2: Find the leftmost boundary of the unsorted subarray.
    // Iterate from right to left, maintaining the minimum element encountered so far.
    // If the current element is greater than the minimum seen, it means this element
    // is out of place and needs to be part of the sorted subarray.
    // This index is a candidate for the left boundary.
    let minSeen = Infinity;
    for (let i = n - 1; i >= 0; i--) {
        if (nums[i] > minSeen) {
            left = i;
        } else {
            minSeen = nums[i];
        }
    }

    // If 'left' is still -1, it means the entire array was already sorted.
    if (left === -1) {
        return 0;
    }

    // The length of the unsorted subarray is (right - left + 1).
    return right - left + 1;
};