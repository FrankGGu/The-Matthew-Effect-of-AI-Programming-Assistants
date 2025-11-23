var getSmallestString = function(n, k) {
    const result = new Array(n);
    for (let i = n - 1; i >= 0; i--) {
        let value = Math.min(26, k - i);
        result[i] = String.fromCharCode(96 + value);
        k -= value;
    }
    return result.join('');
};