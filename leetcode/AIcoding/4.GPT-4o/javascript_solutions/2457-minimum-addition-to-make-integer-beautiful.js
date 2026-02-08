var minimumAddition = function(n, target) {
    let sum = 0;
    let beautiful = n;

    while (true) {
        let digitSum = beautiful.toString().split('').reduce((acc, digit) => acc + Number(digit), 0);
        if (digitSum <= target) {
            return sum;
        }
        beautiful++;
        sum++;
    }
};