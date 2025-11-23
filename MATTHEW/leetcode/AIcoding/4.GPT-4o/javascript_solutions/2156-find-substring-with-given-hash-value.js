function subStrHash(s, power, modulo, k, hashValue) {
    const n = s.length;
    let hash = 0;
    let p = 1;

    for (let i = n - 1; i >= n - k; i--) {
        hash = (hash + (s[i].charCodeAt() - 96) * p) % modulo;
        p = (p * power) % modulo;
    }

    const targetHash = hashValue % modulo;
    if (hash === targetHash) return n - k;

    for (let i = n - k; i > 0; i--) {
        hash = (hash - (s[i + k - 1].charCodeAt() - 96) * p + modulo) % modulo;
        hash = (hash * power + (s[i - 1].charCodeAt() - 96)) % modulo;

        if (hash === targetHash) return i - 1;
    }

    return -1;
}