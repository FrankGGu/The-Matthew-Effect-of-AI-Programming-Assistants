function xorAllOnePairs(A, B) {
    let result = 0;
    for (let i = 0; i < A.length; i++) {
        for (let j = 0; j < B.length; j++) {
            result ^= (A[i] ^ B[j]);
        }
    }
    return result;
}