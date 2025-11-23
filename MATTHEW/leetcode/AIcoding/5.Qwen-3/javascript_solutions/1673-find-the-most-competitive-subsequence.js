function mostCompetitive(nums, k) {
    const stack = [];
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && stack[stack.length - 1] > nums[i] && stack.length + n - i > k) {
            stack.pop();
        }
        if (stack.length < k) {
            stack.push(nums[i]);
        }
    }
    return stack;
}