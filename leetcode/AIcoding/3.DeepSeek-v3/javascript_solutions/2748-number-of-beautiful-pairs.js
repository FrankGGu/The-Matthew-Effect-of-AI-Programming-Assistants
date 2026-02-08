var countBeautifulPairs = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let firstDigit = parseInt(nums[i].toString()[0]);
        for (let j = i + 1; j < nums.length; j++) {
            let lastDigit = nums[j] % 10;
            if (gcd(firstDigit, lastDigit) === 1) {
                count++;
            }
        }
    }
    return count;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}