var punishmentNumber = function(n) {
    let total = 0;
    for (let i = 1; i <= n; i++) {
        let square = i * i;
        if (isPunishment(square)) {
            total += square;
        }
    }
    return total;
};

function isPunishment(num) {
    let str = num.toString();
    let sum = 0;
    for (let char of str) {
        sum += parseInt(char);
    }
    return sum * sum === num;
}