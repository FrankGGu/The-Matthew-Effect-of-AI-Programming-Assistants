var splitNum = function(num) {
    const digits = num.toString().split('').sort();
    let num1 = '';
    let num2 = '';
    for (let i = 0; i < digits.length; i++) {
        if (i % 2 === 0) {
            num1 += digits[i];
        } else {
            num2 += digits[i];
        }
    }
    return parseInt(num1 || '0') + parseInt(num2 || '0');
};