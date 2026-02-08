function baseNeg2(n) {
    if (n === 0) return "0";
    let res = "";
    while (n !== 0) {
        let remainder = n % -2;
        n = Math.floor(n / -2);
        if (remainder < 0) {
            remainder += 2;
            n += 1;
        }
        res = remainder + res;
    }
    return res;
}