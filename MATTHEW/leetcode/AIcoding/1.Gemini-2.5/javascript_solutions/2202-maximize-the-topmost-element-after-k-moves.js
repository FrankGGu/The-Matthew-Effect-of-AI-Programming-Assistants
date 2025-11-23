var maximizeTopmostElement = function(nums, k) {
    const n = nums.length;

    if (n === 0) {
        return -1;
    }

    // Special case for n = 1
    // If k = 1, we remove the only element, array becomes empty. No topmost element.
    // If k > 1 and k is even, we can remove nums[0] and add it back (2 moves).
    // The remaining k-2 moves are even, so we can perform (k-2)/2 pairs of remove/add operations
    // on nums[0] itself, keeping it at the top. So nums[0] is the answer.
    // If k > 1 and k is odd, we remove nums[0] and add it back (2 moves).
    // The remaining k-2 moves are odd. We must perform an odd number of operations.
    // The last operation will either be a removal (making array empty) or an addition (but we'd need to remove something else first, which isn't possible as there's only one element).
    // So, if k is odd and n=1, we cannot have an element at the top.
    if (n === 1) {
        if (k % 2 === 1) {
            return -1;
        } else {
            return nums[0];
        }
    }

    let maxVal = -1;

    // Case 1: An element nums[i] is removed from the top and then added back.
    // To make nums[i] the topmost element:
    // 1. Remove nums[0], ..., nums[i-1] (i moves).
    // 2. Remove nums[i] (1 move). Now nums[i] is in hand.
    // 3. Add nums[i] back to the top (1 move).
    // Total moves: i + 2.
    // We need i+2 <= k. This implies i <= k-2.
    // The number of remaining moves is k - (i + 2).
    // If k - (i + 2) is non-negative and even, we can perform (k - (i+2))/2 pairs of remove/add operations
    // (e.g., removing nums[i] and adding it back) to maintain nums[i] at the top.
    // The loop iterates for i from 0 up to min(n-1, k-2).
    // i < n ensures nums[i] exists.
    // i <= k-2 ensures we have enough moves (at least i+2 moves) to perform the remove-and-add-back operation.
    for (let i = 0; i < n && i <= k - 2; i++) {
        maxVal = Math.max(maxVal, nums[i]);
    }

    // Case 2: The element nums[k] is at the top after exactly k removals.
    // This is possible if k < n (i.e., nums[k] exists and is not removed).
    // We perform k removals (nums[0] through nums[k-1]).
    // After k moves, nums[k] is at the top.
    if (k < n) {
        maxVal = Math.max(maxVal, nums[k]);
    }

    return maxVal;
};