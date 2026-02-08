function decode(encoded) {
    const n = encoded.length + 1;
    const totalXor = Array.from({ length: n + 1 }, (_, i) => i).reduce((a, b) => a ^ b);
    const oddXor = encoded.reduce((a, b, i) => (i % 2 === 0 ? a : a ^ b), 0);
    const first = totalXor ^ oddXor;
    const perm = [first];

    for (let i = 0; i < encoded.length; i++) {
        perm[i + 1] = perm[i] ^ encoded[i];
    }

    return perm;
}