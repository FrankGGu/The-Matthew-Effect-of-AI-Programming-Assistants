var numberOfSpecialNumbers = function(n) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (!isSpecial(i)) {
            count++;
        }
    }
    return count;
};

function isSpecial(num) {
    const digits = num.toString().split('');
    const seen = new Set();
    for (const digit of digits) {
        if (seen.has(digit)) {
            return true;
        }
        seen.add(digit);
    }
    return false;
}