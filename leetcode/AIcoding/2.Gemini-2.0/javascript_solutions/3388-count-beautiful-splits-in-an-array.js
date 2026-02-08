var countBeautifulPairs = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (gcd(nums[i], nums[j]) === 1) {
                count++;
            }
        }
    }
    return count;

    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};