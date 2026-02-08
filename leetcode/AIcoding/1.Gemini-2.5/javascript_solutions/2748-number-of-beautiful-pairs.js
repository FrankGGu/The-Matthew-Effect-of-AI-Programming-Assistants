var countBeautifulPairs = function(nums) {
    let count = 0;

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    for (let i = 0; i < nums.length; i++) {
        let firstDigit_i = parseInt(String(nums[i])[0]);

        for (let j = i + 1; j < nums.length; j++) {
            let lastDigit_j = nums[j] % 10;

            if (gcd(firstDigit_i, lastDigit_j) === 1) {
                count++;
            }
        }
    }

    return count;
};