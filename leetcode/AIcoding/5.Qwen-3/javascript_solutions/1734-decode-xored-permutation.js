function decodeXOR(encoded) {
    const n = encoded.length + 1;
    let xorAll = 0;
    for (let i = 1; i <= n; i++) {
        xorAll ^= i;
    }
    let xorEncoded = 0;
    for (let i = 0; i < encoded.length; i++) {
        xorEncoded ^= encoded[i];
    }
    const perm = new Array(n);
    perm[0] = xorAll ^ xorEncoded;
    for (let i = 1; i < n; i++) {
        perm[i] = perm[i - 1] ^ encoded[i - 1];
    }
    return perm;
}