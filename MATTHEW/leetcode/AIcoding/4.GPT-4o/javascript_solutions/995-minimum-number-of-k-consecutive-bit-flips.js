function minKBitFlips(A, K) {
    let n = A.length;
    let flips = 0;
    let flip = Array(n).fill(0);
    let currentFlip = 0;

    for (let i = 0; i < n; i++) {
        currentFlip ^= flip[i];

        if ((A[i] ^ currentFlip) === 0) {
            if (i + K > n) return -1;
            flips++;
            currentFlip ^= 1;
            if (i + K < n) flip[i + K] ^= 1;
        }
    }

    return flips;
}