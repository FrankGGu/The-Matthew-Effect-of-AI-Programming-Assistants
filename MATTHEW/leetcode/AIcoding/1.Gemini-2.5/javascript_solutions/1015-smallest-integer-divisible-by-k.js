var smallestRepunitDivByK = function(K) {
    if (K % 2 === 0 || K % 5 === 0) {
        return -1;
    }

    let remainder = 0;
    for (let length = 1; length <= K; length++) {
        remainder = (remainder * 10 + 1) % K;
        if (remainder === 0) {
            return length;
        }
    }
};