var smallestGoodBase = function(n) {
    let num = BigInt(n);
    for (let m = 60; m >= 2; m--) {
        let k = BigInt(Math.floor(Math.pow(num, 1 / (m - 1))));
        let sum = BigInt(1), curr = BigInt(1);
        for (let i = 0; i < m; i++) {
            sum += curr;
            curr *= k;
        }
        if (sum === num) {
            return k.toString();
        }
    }
    return (num - BigInt(1)).toString();
};