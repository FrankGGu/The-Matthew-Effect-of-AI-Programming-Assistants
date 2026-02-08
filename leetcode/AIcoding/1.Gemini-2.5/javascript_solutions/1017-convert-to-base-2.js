var baseNeg2 = function(n) {
    if (n === 0) {
        return "0";
    }

    let result = "";
    while (n !== 0) {
        let remainder = n % 2;
        if (remainder < 0) {
            remainder += 2;
        }
        result = remainder + result;
        n = Math.floor((n - remainder) / -2);
    }

    return result;
};