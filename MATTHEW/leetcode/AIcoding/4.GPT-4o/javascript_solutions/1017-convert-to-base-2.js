function baseNeg2(N) {
    if (N === 0) return "0";
    let res = [];
    while (N !== 0) {
        let remainder = N % -2;
        N = Math.floor(N / -2);
        if (remainder < 0) {
            remainder += 2;
            N++;
        }
        res.push(remainder);
    }
    return res.reverse().join('');
}