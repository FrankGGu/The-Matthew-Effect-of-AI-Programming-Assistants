var sumOfEncryptedInt = function(nums) {
    let sum = 0;
    for (let num of nums) {
        let str = num.toString();
        let encrypted = '';
        for (let i = 0; i < str.length; i++) {
            encrypted += '9';
        }
        sum += parseInt(encrypted);
    }
    return sum;
};