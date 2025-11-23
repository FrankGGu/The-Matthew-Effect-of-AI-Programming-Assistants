var maxAlternatingSum = function(nums) {
    let evenSum = 0, oddSum = 0;
    for (let num of nums) {
        evenSum = Math.max(evenSum, oddSum + num);
        oddSum = evenSum - num;
    }
    return evenSum;
};