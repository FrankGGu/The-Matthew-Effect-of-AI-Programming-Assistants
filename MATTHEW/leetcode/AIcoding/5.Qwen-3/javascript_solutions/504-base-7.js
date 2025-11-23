function convertToBase7(num) {
    if (num === 0) return "0";
    let negative = num < 0;
    if (negative) num = -num;
    let result = "";
    while (num > 0) {
        result = (num % 7) + result;
        num = Math.floor(num / 7);
    }
    return negative ? "-" + result : result;
}