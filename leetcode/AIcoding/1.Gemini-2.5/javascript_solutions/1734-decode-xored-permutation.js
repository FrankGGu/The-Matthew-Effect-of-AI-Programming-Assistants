var decode = function(encoded) {
    const n = encoded.length + 1;
    let totalXOR = 0;
    for (let i = 1; i <= n; i++) {
        totalXOR ^= i;
    }

    let xorOfPermOtherThanFirst = 0;
    for (let i = 1; i < n - 1; i += 2) {
        xorOfPermOtherThanFirst ^= encoded[i];
    }

    const perm = new Array(n);
    perm[0] = totalXOR ^ xorOfPermOtherThanFirst;

    for (let i = 0; i < n - 1; i++) {
        perm[i + 1] = perm[i] ^ encoded[i];
    }

    return perm;
};