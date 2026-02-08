var addToArrayForm = function(num, k) {
    let n = num.length;
    let carry = 0;
    let i = n - 1;
    let result = [];

    while (i >= 0 || k > 0 || carry > 0) {
        let sum = carry;
        if (i >= 0) {
            sum += num[i];
            i--;
        }
        if (k > 0) {
            sum += k % 10;
            k = Math.floor(k / 10);
        }

        result.unshift(sum % 10);
        carry = Math.floor(sum / 10);
    }

    return result;
};