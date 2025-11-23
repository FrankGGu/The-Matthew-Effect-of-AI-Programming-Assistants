function sumOfEncryptedIntegers(nums) {
    let sum = 0;
    for (let num of nums) {
        let encryptedNum = 0;
        while (num > 0) {
            encryptedNum += num % 10;
            num = Math.floor(num / 10);
        }
        sum += encryptedNum;
    }
    return sum;
}