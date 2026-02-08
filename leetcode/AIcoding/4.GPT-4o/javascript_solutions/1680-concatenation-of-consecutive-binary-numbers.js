var concatenatedBinary = function(n) {
    let mod = 10n ** 9n + 7n;
    let result = 0n;
    let length = 0;

    for (let i = 1; i <= n; i++) {
        if ((i & (i - 1)) === 0) {
            length++;
        }
        result = ((result << length) | BigInt(i)) % mod;
    }

    return Number(result);
};