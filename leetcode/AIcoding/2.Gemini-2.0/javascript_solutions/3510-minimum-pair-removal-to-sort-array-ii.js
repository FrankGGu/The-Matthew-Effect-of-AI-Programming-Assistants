var minimumPairRemoval = function(nums) {
    let stack = [];
    for (let num of nums) {
        while (stack.length > 0 && num < stack[stack.length - 1]) {
            stack.pop();
        }
        stack.push(num);
    }
    return nums.length - stack.length;
};