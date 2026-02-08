var minimumTimeToRevert = function(word, k) {
    const n = word.length;
    const P = 31;
    const M = 1_000_000_007;

    const p_pow = new Array(n + 1);
    p_pow[0] = 1;
    for (let i = 1; i <= n; i++) {
        p_pow[i] = (p_pow[i - 1] * P) % M;
    }

    const hashes = new Array(n + 1);
    hashes[0] = 0;
    for (let i = 1; i <= n; i++) {
        hashes[i] = (hashes[i - 1] * P + (word.charCodeAt(i - 1) - 'a'.charCodeAt(0) + 1)) % M;
    }

    const getHash = (start, end) => {
        const len = end - start;
        let hash_val = (hashes[end] - (hashes[start] * p_pow[len]) % M + M) % M;
        return hash_val;
    };

    for (let t = 1; ; t++) {
        const startIndex = t * k;
        const currentLength = n - startIndex;

        if (currentLength <= 0) {
            return t;
        }

        const suffixHash = getHash(startIndex, n);
        const prefixHash = getHash(0, currentLength);

        if (suffixHash === prefixHash) {
            return t;
        }
    }
};