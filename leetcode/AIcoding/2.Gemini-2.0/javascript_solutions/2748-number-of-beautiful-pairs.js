var countBeautifulPairs = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            let firstDigit = String(nums[i])[0];
            let lastDigit = String(nums[j]).slice(-1);
            if (gcd(parseInt(firstDigit), parseInt(lastDigit)) === 1) {
                count++;
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
};