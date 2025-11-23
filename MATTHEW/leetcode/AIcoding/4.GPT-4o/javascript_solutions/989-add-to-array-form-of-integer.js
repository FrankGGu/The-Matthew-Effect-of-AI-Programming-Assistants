var addToArrayForm = function(num, k) {
    let result = [];
    let carry = 0;
    let n = num.length;

    for (let i = 0; i < n || k > 0 || carry > 0; i++) {
        if (i < n) carry += num[n - 1 - i];
        if (k > 0) {
            carry += k % 10;
            k = Math.floor(k / 10);
        }
        result.push(carry % 10);
        carry = Math.floor(carry / 10);
    }

    return result.reverse();
};