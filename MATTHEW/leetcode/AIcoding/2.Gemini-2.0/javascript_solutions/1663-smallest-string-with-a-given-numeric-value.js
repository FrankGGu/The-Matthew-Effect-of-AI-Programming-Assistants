var getSmallestString = function(n, k) {
    let result = new Array(n);
    for (let i = n - 1; i >= 0; i--) {
        let val = Math.min(26, k - i);
        result[i] = String.fromCharCode(96 + val);
        k -= val;
    }
    return result.join('');
};