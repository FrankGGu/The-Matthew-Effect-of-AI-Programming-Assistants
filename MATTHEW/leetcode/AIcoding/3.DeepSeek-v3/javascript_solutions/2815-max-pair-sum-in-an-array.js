var maxSum = function(nums) {
    let max = -1;
    const maxDigits = new Map();

    for (const num of nums) {
        let currentMaxDigit = 0;
        let temp = num;
        while (temp > 0) {
            currentMaxDigit = Math.max(currentMaxDigit, temp % 10);
            temp = Math.floor(temp / 10);
        }

        if (maxDigits.has(currentMaxDigit)) {
            const sum = maxDigits.get(currentMaxDigit) + num;
            max = Math.max(max, sum);
            if (num > maxDigits.get(currentMaxDigit)) {
                maxDigits.set(currentMaxDigit, num);
            }
        } else {
            maxDigits.set(currentMaxDigit, num);
        }
    }

    return max;
};