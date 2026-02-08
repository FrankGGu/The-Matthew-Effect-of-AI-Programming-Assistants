var sumOfEncryptedInt = function(nums) {
    let totalSum = 0;

    for (let num of nums) {
        let numStr = String(num);

        let maxDigit = 0;
        for (let i = 0; i < numStr.length; i++) {
            maxDigit = Math.max(maxDigit, parseInt(numStr[i]));
        }

        let encryptedStr = String(maxDigit).repeat(numStr.length);

        totalSum += parseInt(encryptedStr);
    }

    return totalSum;
};