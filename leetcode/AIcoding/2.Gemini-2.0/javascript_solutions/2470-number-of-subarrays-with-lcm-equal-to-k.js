var subarrayLCM = function(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let currentLCM = nums[i];
        for (let j = i; j < nums.length; j++) {
            currentLCM = lcm(currentLCM, nums[j]);
            if (currentLCM === k) {
                count++;
            } else if (currentLCM > k) {
                break;
            }
        }
    }
    return count;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    function lcm(a, b) {
        return (a * b) / gcd(a, b);
    }
};