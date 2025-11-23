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
    for (let num of nums) {
        currentGcd = gcd(currentGcd, num);
        if (currentGcd === 1) {
            return true;
        }
    }
    return currentGcd === 1;
};