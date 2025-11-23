var countSymmetricIntegers = function(low, high) {
    let count = 0;
    for (let num = low; num <= high; num++) {
        const s = num.toString();
        const n = s.length;
        if (n % 2 !== 0) continue;
        let leftSum = 0;
        let rightSum = 0;
        for (let i = 0; i < n / 2; i++) {
            leftSum += parseInt(s[i]);
            rightSum += parseInt(s[n - 1 - i]);
        }
        if (leftSum === rightSum) {
            count++;
        }
    }
    return count;
};