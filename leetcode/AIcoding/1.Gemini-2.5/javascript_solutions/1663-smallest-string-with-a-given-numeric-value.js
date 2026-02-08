var getSmallestString = function(n, k) {
    const result = new Array(n);

    for (let i = n - 1; i >= 0; i--) {
        const charValue = Math.min(26, k - i);
        result[i] = String.fromCharCode(96 + charValue);
        k -= charValue;
    }

    return result.join('');
};