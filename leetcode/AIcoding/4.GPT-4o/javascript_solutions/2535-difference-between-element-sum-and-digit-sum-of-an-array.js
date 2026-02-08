function differenceOfSum(nums) {
    let elementSum = nums.reduce((a, b) => a + b, 0);
    let digitSum = nums.reduce((sum, num) => sum + num.toString().split('').reduce((a, b) => a + Number(b), 0), 0);
    return Math.abs(elementSum - digitSum);
}