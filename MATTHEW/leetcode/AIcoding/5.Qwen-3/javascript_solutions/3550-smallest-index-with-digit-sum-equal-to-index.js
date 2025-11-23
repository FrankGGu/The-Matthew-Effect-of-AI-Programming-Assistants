function digitSum(n) {
    let sum = 0;
    while (n > 0) {
        sum += n % 10;
        n = Math.floor(n / 10);
    }
    return sum;
}

function smallestKDigitIndex(nums) {
    for (let i = 0; i < nums.length; i++) {
        if (digitSum(nums[i]) === i) {
            return i;
        }
    }
    return -1;
}