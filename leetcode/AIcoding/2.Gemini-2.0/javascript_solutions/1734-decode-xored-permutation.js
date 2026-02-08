var decode = function(encoded) {
    const n = encoded.length + 1;
    let totalXor = 0;
    for (let i = 1; i <= n; i++) {
        totalXor ^= i;
    }

    let encodedXor = 0;
    for (let i = 1; i < n - 1; i += 2) {
        encodedXor ^= encoded[i];
    }

    const first = totalXor ^ encodedXor;
    const perm = [first];

    for (let i = 0; i < encoded.length; i++) {
        perm.push(perm[i] ^ encoded[i]);
    }

    return perm;
};