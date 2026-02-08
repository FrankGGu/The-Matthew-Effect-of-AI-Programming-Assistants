var countAnagrams = function(s) {
    const MOD = 10**9 + 7;

    function factorial(n) {
        let res = 1n;
        for (let i = 2n; i <= n; i++) {
            res = (res * i) % BigInt(MOD);
        }
        return res;
    }

    function power(base, exp) {
        let res = 1n;
        base %= BigInt(MOD);
        while (exp > 0n) {
            if (exp % 2n === 1n) res = (res * base) % BigInt(MOD);
            base = (base * base) % BigInt(MOD);
            exp >>= 1n;
        }
        return res;
    }

    function modInverse(n) {
        return power(n, BigInt(MOD) - 2n);
    }

    const words = s.split(" ");
    let n = 1n;
    let totalLength = 0n;
    const counts = [];

    for (const word of words) {
        const wordLength = BigInt(word.length);
        totalLength += wordLength;
        n = (n * factorial(wordLength)) % BigInt(MOD);

        const charCounts = {};
        for (const char of word) {
            charCounts[char] = (charCounts[char] || 0) + 1;
        }

        let denominator = 1n;
        for (const char in charCounts) {
            denominator = (denominator * factorial(BigInt(charCounts[char]))) % BigInt(MOD);
        }
        counts.push(denominator);
    }

    let inverseProduct = 1n;
    for (const count of counts) {
        inverseProduct = (inverseProduct * modInverse(count)) % BigInt(MOD);
    }

    let result = (factorial(totalLength) * inverseProduct) % BigInt(MOD);

    return Number(result);
};