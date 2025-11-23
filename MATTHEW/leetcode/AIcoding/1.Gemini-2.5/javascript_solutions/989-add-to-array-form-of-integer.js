var addToArrayForm = function(num, k) {
    let i = num.length - 1;
    let carry = 0;
    const result = [];

    while (i >= 0 || k > 0 || carry > 0) {
        let digitNum = (i >= 0) ? num[i] : 0;
        let digitK = k % 10;

        let currentSum = digitNum + digitK + carry;

        result.push(currentSum % 10);
        carry = Math.floor(currentSum / 10);

        i--;
        k = Math.floor(k / 10);
    }

    return result.reverse();
};