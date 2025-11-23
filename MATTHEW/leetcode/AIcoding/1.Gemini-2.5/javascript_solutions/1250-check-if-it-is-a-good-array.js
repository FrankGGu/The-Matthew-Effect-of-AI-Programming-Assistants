var isGoodArray = function(nums) {
    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    let currentGcd = nums[0];

    for (let i = 1; i < nums.length; i++) {
        currentGcd = gcd(currentGcd, nums[i]);
        if (currentGcd === 1) {
            return true;
        }
    }

    return currentGcd === 1;
};