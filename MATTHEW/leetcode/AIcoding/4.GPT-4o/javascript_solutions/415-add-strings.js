var addStrings = function(num1, num2) {
    let result = '';
    let carry = 0;
    let i = num1.length - 1;
    let j = num2.length - 1;

    while (i >= 0 || j >= 0 || carry > 0) {
        const x = i >= 0 ? num1[i] - '0' : 0;
        const y = j >= 0 ? num2[j] - '0' : 0;
        const sum = x + y + carry;
        result = (sum % 10) + result;
        carry = Math.floor(sum / 10);
        i--;
        j--;
    }

    return result;
};