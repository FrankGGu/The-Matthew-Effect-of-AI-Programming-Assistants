var findSumOfEncryptedIntegers = function(encryptedNumbers) {
    let sum = 0;
    for (let num of encryptedNumbers) {
        sum += parseInt(num, 2);
    }
    return sum;
};