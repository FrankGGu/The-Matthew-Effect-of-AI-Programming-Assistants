var minOperations = function(nums, numsDivide) {
    const gcd = (a, b) => {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    };

    let g = numsDivide[0];
    for (let i = 1; i < numsDivide.length; i++) {
        g = gcd(g, numsDivide[i]);
    }

    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length; i++) {
        if (g % nums[i] === 0) {
            return i;
        }
    }

    return -1;
};