function maximumSum(numBars, makeK, k) {
    let sum = 0;
    for (let i = 0; i < makeK; i++) {
        sum += Math.min(k, numBars);
        numBars -= Math.min(k, numBars);
    }
    return sum;
}