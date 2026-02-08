var minOperations = function(nums, numsDivide) {
    const gcd = (a, b) => {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    };

    let commonDivisor = numsDivide[0];
    for (let i = 1; i < numsDivide.length; i++) {
        commonDivisor = gcd(commonDivisor, numsDivide[i]);
    }

    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length; i++) {
        if (commonDivisor % nums[i] === 0) {
            return i;
        }
    }

    return -1;
};