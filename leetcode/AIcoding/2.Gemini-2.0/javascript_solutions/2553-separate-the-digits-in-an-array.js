var separateDigits = function(nums) {
    let result = [];
    for (let num of nums) {
        let numStr = String(num);
        for (let digit of numStr) {
            result.push(parseInt(digit));
        }
    }
    return result;
};