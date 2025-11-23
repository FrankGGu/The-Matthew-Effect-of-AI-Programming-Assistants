var countEven = function(num) {
    let count = 0;

    for (let i = 1; i <= num; i++) {
        let currentNum = i;
        let digitSum = 0;
        while (currentNum > 0) {
            digitSum += currentNum % 10;
            currentNum = Math.floor(currentNum / 10);
        }

        if (digitSum % 2 === 0) {
            count++;
        }
    }

    return count;
};