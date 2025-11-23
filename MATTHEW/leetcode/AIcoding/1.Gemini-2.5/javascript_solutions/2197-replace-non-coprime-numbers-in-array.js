var replaceNonCoprimes = function(nums) {
    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    const stack = [];

    for (const num of nums) {
        stack.push(num);

        while (stack.length >= 2) {
            const top1 = stack[stack.length - 2];
            const top2 = stack[stack.length - 1];

            const commonDivisor = gcd(top1, top2);

            if (commonDivisor === 1) {
                break;
            } else {
                stack.pop();
                stack.pop();
                const lcm = (top1 / commonDivisor) * top2;
                stack.push(lcm);
            }
        }
    }

    return stack;
};