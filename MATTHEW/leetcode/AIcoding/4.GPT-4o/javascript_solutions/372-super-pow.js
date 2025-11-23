var superPow = function(a, b) {
    const mod = 1337;
    a %= mod;

    const pow = (base, exp) => {
        let result = 1;
        while (exp > 0) {
            if (exp % 2 === 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return result;
    };

    let result = 1;
    for (let i = 0; i < b.length; i++) {
        result = (result * pow(a, b[b.length - 1 - i])) % mod;
        a = pow(a, 10);
    }

    return result;
};