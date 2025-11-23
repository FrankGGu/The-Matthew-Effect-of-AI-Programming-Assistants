var makeIntegerBeautiful = function(n, target) {
    let num = n;
    while (sumDigits(num) > target) {
        let str = num.toString();
        let len = str.length;
        let lastDigit = parseInt(str[len - 1]);
        let add = 10 - lastDigit;
        num += add;
    }
    return num - n;

    function sumDigits(num) {
        let sum = 0;
        let str = num.toString();
        for (let i = 0; i < str.length; i++) {
            sum += parseInt(str[i]);
        }
        return sum;
    }
};