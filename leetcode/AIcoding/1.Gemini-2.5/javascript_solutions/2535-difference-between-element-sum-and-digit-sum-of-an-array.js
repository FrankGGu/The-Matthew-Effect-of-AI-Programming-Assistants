var differenceOfSum = function(nums) {
    let elementSum = 0;
    let digitSum = 0;

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        elementSum += num;

        let temp = num;
        while (temp > 0) {
            digitSum += temp % 10;
            temp = Math.floor(temp / 10);
        }
    }

    return Math.abs(elementSum - digitSum);
};