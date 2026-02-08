var addToArrayForm = function(num, k) {
    let carry = 0;
    let i = num.length - 1;
    const res = [];

    while (i >= 0 || k > 0 || carry > 0) {
        const digitNum = i >= 0 ? num[i] : 0;
        const digitK = k % 10;
        const sum = digitNum + digitK + carry;
        res.unshift(sum % 10);
        carry = Math.floor(sum / 10);
        i--;
        k = Math.floor(k / 10);
    }

    return res;
};