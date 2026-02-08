var minOperations = function(nums, numsDivide) {
    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    let overallGCD = numsDivide[0];
    for (let num of numsDivide) {
        overallGCD = gcd(overallGCD, num);
    }

    nums.sort((a, b) => a - b);
    for (let i = 0; i < nums.length; i++) {
        if (overallGCD % nums[i] === 0) {
            return i;
        }
    }
    return -1;
};