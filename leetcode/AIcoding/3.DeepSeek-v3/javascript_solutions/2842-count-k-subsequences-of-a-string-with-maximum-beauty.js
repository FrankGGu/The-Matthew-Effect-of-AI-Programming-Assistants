var countKSubsequencesWithMaxBeauty = function(s, k) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }

    const values = Object.values(freq).sort((a, b) => b - a);
    if (values.length < k) {
        return 0;
    }

    const target = values[k - 1];
    let total = 1;
    let count = 0;
    let selected = 0;

    for (const v of values) {
        if (v > target) {
            selected++;
            total = (total * v) % (1e9 + 7);
        } else if (v === target) {
            count++;
        }
    }

    const remaining = k - selected;
    if (remaining <= 0) {
        return total;
    }

    let comb = 1;
    for (let i = 0; i < remaining; i++) {
        comb = (comb * (count - i)) % (1e9 + 7);
    }
    let inv = 1;
    for (let i = 1; i <= remaining; i++) {
        inv = (inv * i) % (1e9 + 7);
    }
    inv = modInverse(inv, 1e9 + 7);
    comb = (comb * inv) % (1e9 + 7);

    for (let i = 0; i < remaining; i++) {
        total = (total * target) % (1e9 + 7);
    }
    total = (total * comb) % (1e9 + 7);

    return total;
};

function modInverse(a, mod) {
    let b = mod;
    let [x, y, u, v] = [0, 1, 1, 0];
    while (a !== 0) {
        const q = Math.floor(b / a);
        [x, y, u, v] = [u, v, x - u * q, y - v * q];
        [a, b] = [b % a, a];
    }
    return (x % mod + mod) % mod;
}