function minStartValue(nums) {
    let sum = 0;
    let minSum = 0;
    for (let num of nums) {
        sum += num;
        minSum = Math.min(minSum, sum);
    }
    return Math.abs(minSum) + 1;
}