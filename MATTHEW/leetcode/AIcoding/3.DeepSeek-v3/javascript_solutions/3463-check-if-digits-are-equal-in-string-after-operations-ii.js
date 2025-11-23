var digitCount = function(num) {
    const count = new Array(10).fill(0);
    for (const c of num) {
        count[parseInt(c)]++;
    }
    for (let i = 0; i < num.length; i++) {
        if (parseInt(num[i]) !== count[i]) {
            return false;
        }
    }
    return true;
};