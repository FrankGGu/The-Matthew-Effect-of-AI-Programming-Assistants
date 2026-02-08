var makeIntegerBeautiful = function(n, target) {
    let sumDigits = (num) => {
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        return sum;
    };

    let original = n;
    let add = 0;
    let power = 1;

    while (sumDigits(n) > target) {
        let lastNonZero = n % 10;
        let diff = 10 - lastNonZero;
        add += diff * power;
        n = Math.floor(n / 10) + 1;
        power *= 10;
    }

    return add;
};