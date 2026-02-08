var maxArrayValue = function(nums) {
    let stack = [];
    for (let num of nums) {
        stack.push(num);
        while (stack.length > 1 && stack[stack.length - 2] <= stack[stack.length - 1]) {
            let last = stack.pop();
            let secondLast = stack.pop();
            stack.push(last + secondLast);
        }
    }
    return Math.max(...stack);
};