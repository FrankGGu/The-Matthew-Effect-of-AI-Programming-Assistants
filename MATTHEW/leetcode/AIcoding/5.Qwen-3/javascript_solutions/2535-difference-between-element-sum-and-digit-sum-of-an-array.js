function differenceBetweenElementSum(nums) {
    let elementSum = 0;
    let digitSum = 0;

    for (let num of nums) {
        elementSum += num;
        let digits = String(num).split('');
        for (let digit of digits) {
            digitSum += parseInt(digit);
        }
    }

    return elementSum - digitSum;
}