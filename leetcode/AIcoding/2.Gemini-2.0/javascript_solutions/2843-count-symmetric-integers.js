var countSymmetricIntegers = function(low, high) {
    let count = 0;
    for (let i = low; i <= high; i++) {
        const s = String(i);
        const n = s.length;
        if (n % 2 === 0) {
            let sum1 = 0;
            let sum2 = 0;
            for (let j = 0; j < n / 2; j++) {
                sum1 += parseInt(s[j]);
            }
            for (let j = n / 2; j < n; j++) {
                sum2 += parseInt(s[j]);
            }
            if (sum1 === sum2) {
                count++;
            }
        }
    }
    return count;
};