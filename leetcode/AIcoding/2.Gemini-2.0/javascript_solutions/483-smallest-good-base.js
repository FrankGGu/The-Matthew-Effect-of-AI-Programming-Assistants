var smallestGoodBase = function(n) {
    const num = parseInt(n);
    let m = Math.floor(Math.log(num + 1) / Math.log(2));
    while (m > 1) {
        let k = Math.floor(Math.pow(num, 1 / m));
        let sum = 1;
        let power = 1;
        for (let i = 1; i <= m; i++) {
            power *= k;
            sum += power;
        }
        if (sum === num) {
            return String(k);
        }
        m--;
    }
    return String(num - 1);
};