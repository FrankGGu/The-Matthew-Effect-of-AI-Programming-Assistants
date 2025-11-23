var rotatedDigits = function(N) {
    let count = 0;
    for (let i = 1; i <= N; i++) {
        if (isGood(i)) {
            count++;
        }
    }
    return count;
};

function isGood(num) {
    let valid = false;
    while (num > 0) {
        let digit = num % 10;
        if (digit === 3 || digit === 4 || digit === 7) {
            return false;
        }
        if (digit === 2 || digit === 5 || digit === 6 || digit === 9) {
            valid = true;
        }
        num = Math.floor(num / 10);
    }
    return valid;
}