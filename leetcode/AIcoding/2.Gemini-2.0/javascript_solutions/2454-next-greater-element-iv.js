var nextGreaterElements = function(nums) {
    const n = nums.length;
    const res = new Array(n).fill(-1);
    const stack1 = [];
    const stack2 = [];

    for (let i = 0; i < n; i++) {
        while (stack2.length > 0 && nums[stack2[stack2.length - 1]] < nums[i]) {
            res[stack2.pop()] = nums[i];
        }

        let tempStack = [];
        while (stack1.length > 0 && nums[stack1[stack1.length - 1]] < nums[i]) {
            tempStack.push(stack1.pop());
        }

        while (tempStack.length > 0) {
            stack2.push(tempStack.pop());
        }

        stack1.push(i);
    }

    return res;
};