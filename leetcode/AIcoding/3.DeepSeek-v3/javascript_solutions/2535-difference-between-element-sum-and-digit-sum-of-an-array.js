var differenceOfSum = function(nums) {
    let elementSum = 0;
    let digitSum = 0;

    for (const num of nums) {
        elementSum += num;
        let current = num;
        while (current > 0) {
            digitSum += current % 10;
            current = Math.floor(current / 10);
        }
    }

    return Math.abs(elementSum - digitSum);
};