var smallestRangeII = function(A, K) {
    const maxA = Math.max(...A);
    const minA = Math.min(...A);
    let result = maxA - minA;

    for (let num of A) {
        let high = Math.max(maxA, num + K);
        let low = Math.min(minA, num - K);
        result = Math.min(result, high - low);
    }

    return result;
};