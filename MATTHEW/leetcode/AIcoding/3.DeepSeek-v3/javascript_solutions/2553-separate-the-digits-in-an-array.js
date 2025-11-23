var separateDigits = function(nums) {
    let result = [];
    for (let num of nums) {
        let digits = num.toString().split('');
        for (let digit of digits) {
            result.push(parseInt(digit));
        }
    }
    return result;
};