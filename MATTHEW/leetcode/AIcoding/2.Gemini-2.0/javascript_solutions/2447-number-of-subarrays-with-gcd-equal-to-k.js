var subarrayGCD = function(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let gcd = 0;
        for (let j = i; j < nums.length; j++) {
            gcd = findGCD(gcd, nums[j]);
            if (gcd === k) {
                count++;
            }
        }
    }
    return count;

    function findGCD(a, b) {
        if (b === 0) {
            return a;
        }
        return findGCD(b, a % b);
    }
};