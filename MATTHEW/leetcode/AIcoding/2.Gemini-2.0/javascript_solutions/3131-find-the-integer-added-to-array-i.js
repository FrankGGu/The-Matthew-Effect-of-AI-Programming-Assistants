var addToArrayForm = function(num, k) {
    let n = num.length;
    let carry = 0;
    let result = [];

    for (let i = n - 1; i >= 0 || k > 0 || carry > 0; i--) {
        let digit1 = (i >= 0) ? num[i] : 0;
        let digit2 = k % 10;
        k = Math.floor(k / 10);

        let sum = digit1 + digit2 + carry;
        carry = Math.floor(sum / 10);
        result.unshift(sum % 10);
    }

    return result;
};