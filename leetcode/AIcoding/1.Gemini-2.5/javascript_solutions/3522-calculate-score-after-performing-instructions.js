var maxResult = function(nums, k) {
    const n = nums.length;
    // The deque stores indices of nums, such that nums[deque[0]] is the maximum score
    // in the current sliding window [i - k, i - 1].
    // The deque maintains indices in decreasing order of their corresponding nums (dp) values.
    const deque = [];

    // Initialize the deque with the first index.
    // The score to reach index 0 is simply nums[0].
    deque.push(0);

    // Iterate from the second element to the end of the array.
    for (let i = 1; i < n; i++) {
        // 1. Remove indices from the front of the deque that are out of the k-step window.
        // An index `j` is out of window if `j < i - k`.
        while (deque.length > 0 && deque[0] < i - k) {
            deque.shift(); // Remove from the front (left)
        }

        // 2. Calculate the score for the current index `i`.
        // The score is `nums[i]` plus the maximum score from a valid previous index.
        // The maximum score from a valid previous index is `nums[deque[0]]` because
        // the deque front always holds the index with the highest score in the window.
        nums[i] += nums[deque[0]];

        // 3. Maintain the deque in decreasing order of scores.
        // Remove indices from the back if their scores are less than or equal to the current score `nums[i]`.
        // This is because `nums[i]` is a better or equally good option for future steps (as it's closer or has a higher/equal score).
        while (deque.length > 0 && nums[deque[deque.length - 1]] <= nums[i]) {
            deque.pop(); // Remove from the back (right)
        }

        // 4. Add the current index `i` to the back of the deque.
        deque.push(i);
    }

    // The maximum score to reach the last index (n-1) is stored in nums[n-1].
    return nums[n - 1];
};