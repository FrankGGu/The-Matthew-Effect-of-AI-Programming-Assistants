var minInteger = function(num, k) {
    const digits = num.split('');
    const n = digits.length;

    for (let i = 0; i < n && k > 0; i++) {
        let minDigit = digits[i];
        let minIndex = i;

        for (let j = i + 1; j < n && j <= i + k; j++) {
            if (digits[j] < minDigit) {
                minDigit = digits[j];
                minIndex = j;
            }
        }

        if (minIndex !== i) {
            for (let j = minIndex; j > i; j--) {
                [digits[j], digits[j - 1]] = [digits[j - 1], digits[j]];
                k--;
            }
        }
    }

    return digits.join('');
};