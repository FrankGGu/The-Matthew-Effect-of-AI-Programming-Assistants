function modularExponentiation(a, b, mod) {
    let result = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) {
            result = (result * a) % mod;
        }
        b = Math.floor(b / 2);
        a = (a * a) % mod;
    }
    return result;
}

function doubleModularExponentiation(a, b, c, d, mod) {
    const first = modularExponentiation(a, b, mod);
    const second = modularExponentiation(c, d, mod);
    return (first + second) % mod;
}