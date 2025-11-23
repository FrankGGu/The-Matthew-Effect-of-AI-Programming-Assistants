var digitCount = function(num) {
    const count = {};
    for (const digit of num) {
        count[digit] = (count[digit] || 0) + 1;
    }
    for (let i = 0; i < num.length; i++) {
        const expected = parseInt(num[i]);
        const actual = count[i] || 0;
        if (expected !== actual) {
            return false;
        }
    }
    return true;
};