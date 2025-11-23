var findGCD = function(nums) {
    let minVal = Infinity;
    let maxVal = -Infinity;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    return gcd(minVal, maxVal);
};