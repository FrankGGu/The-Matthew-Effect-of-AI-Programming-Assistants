var decode = function(encoded) {
    const n = encoded.length + 1;
    let total = 0;
    for (let i = 1; i <= n; i++) {
        total ^= i;
    }
    let odd = 0;
    for (let i = 1; i < encoded.length; i += 2) {
        odd ^= encoded[i];
    }
    const perm = new Array(n);
    perm[0] = total ^ odd;
    for (let i = 1; i < n; i++) {
        perm[i] = perm[i - 1] ^ encoded[i - 1];
    }
    return perm;
};