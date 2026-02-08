function countAnagrams(words) {
    const mod = 1e9 + 7;
    const factorial = (n) => {
        let res = 1;
        for (let i = 2; i <= n; i++) {
            res = (res * i) % mod;
        }
        return res;
    };

    const charCount = (word) => {
        const count = Array(26).fill(0);
        for (const char of word) {
            count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return count;
    };

    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    const lcm = (a, b) => (a * (b / gcd(a, b))) % mod;

    let totalAnagrams = 1;
    for (const word of words) {
        const count = charCount(word);
        let denom = 1;
        for (const c of count) {
            if (c > 1) {
                denom = (denom * factorial(c)) % mod;
            }
        }
        totalAnagrams = (totalAnagrams * factorial(word.length)) % mod;
        totalAnagrams = (totalAnagrams * pow(denom, mod - 2)) % mod;
    }

    return totalAnagrams;
}

function pow(x, n) {
    let res = 1;
    while (n > 0) {
        if (n % 2 === 1) {
            res = (res * x) % (1e9 + 7);
        }
        x = (x * x) % (1e9 + 7);
        n = Math.floor(n / 2);
    }
    return res;
}