var replaceNonCoprime = function(nums) {
    const gcd = (a, b) => {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    const lcm = (a, b) => {
        return (a * b) / gcd(a, b);
    };

    let stack = [];
    for (let num of nums) {
        while (stack.length > 0 && gcd(stack[stack.length - 1], num) > 1) {
            num = lcm(stack.pop(), num);
        }
        stack.push(num);
    }

    return stack;
};