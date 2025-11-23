var sumOfEncryptedNumbers = function(nums) {
    let sum = 0;
    for (let num of nums) {
        let str = num.toString();
        let maxDigit = 0;
        for (let c of str) {
            let digit = parseInt(c);
            if (digit > maxDigit) {
                maxDigit = digit;
            }
        }
        let encrypted = maxDigit.toString().repeat(str.length);
        sum += parseInt(encrypted);
    }
    return sum;
};