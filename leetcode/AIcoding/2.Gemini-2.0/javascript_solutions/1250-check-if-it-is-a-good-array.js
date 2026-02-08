var isGoodArray = function(nums) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let result = nums[0];
    for (let i = 1; i < nums.length; i++) {
        result = gcd(result, nums[i]);
    }

    return result === 1;
};