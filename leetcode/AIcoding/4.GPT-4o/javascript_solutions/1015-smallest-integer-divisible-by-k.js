var smallestRepunitDivByK = function(K) {
    if (K % 2 === 0 || K % 5 === 0) return -1;
    let num = 1;
    for (let i = 1; i <= K; i++) {
        if (num % K === 0) return i;
        num = (num * 10 + 1) % K;
    }
    return -1;
};