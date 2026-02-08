var differenceOfSum = function(nums) {
    let elementSum = 0;
    let digitSum = 0;

    for (let num of nums) {
        elementSum += num;

        let numStr = num.toString();
        for (let i = 0; i < numStr.length; i++) {
            digitSum += parseInt(numStr[i]);
        }
    }

    return Math.abs(elementSum - digitSum);
};