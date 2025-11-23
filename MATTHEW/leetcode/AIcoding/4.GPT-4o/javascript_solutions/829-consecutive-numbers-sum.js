var consecutiveNumbersSum = function(N) {
    let count = 0;
    for (let k = 1; k * (k + 1) / 2 <= N; k++) {
        if ((N - (k * (k + 1)) / 2) % k === 0) {
            count++;
        }
    }
    return count;
};