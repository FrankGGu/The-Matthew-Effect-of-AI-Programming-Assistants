var digitCount = function(num) {
    const count = new Array(10).fill(0);
    for (const ch of num) {
        const digit = parseInt(ch, 10);
        count[digit]++;
    }
    for (let i = 0; i < num.length; i++) {
        const expected = parseInt(num[i], 10);
        if (count[i] !== expected) {
            return false;
        }
    }
    return true;
};