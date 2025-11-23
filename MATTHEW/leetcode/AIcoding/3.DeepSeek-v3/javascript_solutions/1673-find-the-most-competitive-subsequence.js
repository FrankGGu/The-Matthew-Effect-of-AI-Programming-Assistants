var mostCompetitive = function(nums, k) {
    let stack = [];
    let n = nums.length;
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[i] < stack[stack.length - 1] && stack.length + n - i - 1 >= k) {
            stack.pop();
        }
        if (stack.length < k) {
            stack.push(nums[i]);
        }
    }
    return stack;
};