function findCoprimes(nums) {
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const replaceCoprimes = (arr) => {
        const stack = [];
        for (const num of arr) {
            while (stack.length && gcd(stack[stack.length - 1], num) > 1) {
                num *= stack.pop();
            }
            stack.push(num);
        }
        return stack;
    };
    return replaceCoprimes(nums);
}