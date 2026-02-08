var isPerfectSquare = function(num) {
    if (num < 1) {
        return false;
    }
    const s = Math.sqrt(num);
    return Number.isInteger(s);
};