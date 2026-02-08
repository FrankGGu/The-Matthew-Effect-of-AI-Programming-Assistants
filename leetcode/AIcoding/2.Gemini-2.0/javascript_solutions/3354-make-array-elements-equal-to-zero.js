var canMakeSubarraySumsZero = function(nums) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }
    return sum === 0;
};