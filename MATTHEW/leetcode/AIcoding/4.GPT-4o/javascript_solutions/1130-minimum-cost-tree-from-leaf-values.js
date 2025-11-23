var mctFromLeafValues = function(arr) {
    let stack = [];
    let res = 0;

    for (let num of arr) {
        while (stack.length && stack[stack.length - 1] <= num) {
            const mid = stack.pop();
            if (stack.length) {
                res += mid * Math.min(stack[stack.length - 1], num);
            }
        }
        stack.push(num);
    }

    while (stack.length > 1) {
        res += stack.pop() * stack[stack.length - 1];
    }

    return res;
};