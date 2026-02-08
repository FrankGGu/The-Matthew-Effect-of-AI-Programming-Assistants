var smallestGoodBase = function(n) {
    const num = BigInt(n);
    const maxM = Math.floor(Math.log2(Number(num)) + 1;

    for (let m = maxM; m >= 2; m--) {
        const k = BigInt(Math.floor(Math.pow(Number(num), 1 / (m - 1))));
        if (k < 2) continue;

        let sum = BigInt(0);
        for (let i = 0; i < m; i++) {
            sum = sum * k + BigInt(1);
        }

        if (sum === num) {
            return k.toString();
        }
    }

    return (num - BigInt(1)).toString();
};