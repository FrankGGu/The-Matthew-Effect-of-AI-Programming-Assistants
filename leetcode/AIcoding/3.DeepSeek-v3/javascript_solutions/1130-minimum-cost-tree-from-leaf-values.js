var mctFromLeafValues = function(arr) {
    let res = 0;
    let stack = [Infinity];

    for (let num of arr) {
        while (stack[stack.length - 1] <= num) {
            let mid = stack.pop();
            res += mid * Math.min(stack[stack.length - 1], num);
        }
        stack.push(num);
    }

    while (stack.length > 2) {
        res += stack.pop() * stack[stack.length - 1];
    }

    return res;
};