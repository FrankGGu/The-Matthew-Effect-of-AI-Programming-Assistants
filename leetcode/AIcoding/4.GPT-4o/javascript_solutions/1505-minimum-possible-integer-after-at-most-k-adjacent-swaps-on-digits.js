var minimumInteger = function(num, k) {
    let digits = num.split('');
    let n = digits.length;

    for (let i = 0; i < n; i++) {
        if (k <= 0) break;
        let minIndex = i;
        for (let j = i + 1; j < Math.min(n, i + k + 1); j++) {
            if (digits[j] < digits[minIndex]) {
                minIndex = j;
            }
        }
        if (minIndex !== i) {
            let swaps = minIndex - i;
            if (swaps <= k) {
                [digits[i], digits[minIndex]] = [digits[minIndex], digits[i]];
                k -= swaps;
            }
        }
    }

    return digits.join('');
};