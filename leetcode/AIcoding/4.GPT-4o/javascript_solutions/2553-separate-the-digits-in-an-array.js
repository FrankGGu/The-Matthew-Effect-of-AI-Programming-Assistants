var separateDigits = function(nums) {
    let result = [];
    for (let num of nums) {
        let digits = String(num).split('');
        result.push(...digits.map(Number));
    }
    return result;
};