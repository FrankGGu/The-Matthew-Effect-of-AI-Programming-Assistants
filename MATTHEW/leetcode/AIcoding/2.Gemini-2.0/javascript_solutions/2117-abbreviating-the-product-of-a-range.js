var abbreviateProduct = function(left, right) {
    let product = 1;
    let trailingZeros = 0;
    const MOD = 100000;
    let overflow = false;

    for (let i = left; i <= right; i++) {
        let num = i;
        while (num % 2 === 0) {
            num /= 2;
            trailingZeros++;
        }
        while (num % 5 === 0) {
            num /= 5;
            trailingZeros++;
        }

        product *= num;
        if (product > 100000000000) {
            overflow = true;
            product %= MOD;
        }
    }

    let s = String(product);
    if (overflow) {
        while (s.length < 5) {
            s = '0' + s;
        }
        return s.slice(0, 5) + '...' + s.slice(s.length - 5) + 'e' + trailingZeros;
    } else {
        return s + 'e' + trailingZeros;
    }
};