var mostCompetitive = function(nums, k) {
    const stack = [];
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        const num = nums[i];

        while (stack.length > 0 && num < stack[stack.length - 1] && (n - i - 1) >= (k - stack.length)) {
            stack.pop();
        }

        if (stack.length < k) {
            stack.push(num);
        }
    }

    return stack;
};