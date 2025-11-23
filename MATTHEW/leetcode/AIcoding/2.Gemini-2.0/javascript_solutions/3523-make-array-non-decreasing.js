var makeArrayNonDecreasing = function(nums) {
    let stack = [];
    for (let num of nums) {
        while (stack.length > 0 && num < stack[stack.length - 1]) {
            num = Math.floor((num + stack.pop()) / 2);
        }
        stack.push(num);
    }
    return stack.length;
};