var convertToBase7 = function(num) {
    if (num === 0) return "0";
    let isNegative = num < 0;
    num = Math.abs(num);
    let result = [];
    while (num > 0) {
        result.push(num % 7);
        num = Math.floor(num / 7);
    }
    if (isNegative) {
        result.push('-');
    }
    return result.reverse().join('');
};