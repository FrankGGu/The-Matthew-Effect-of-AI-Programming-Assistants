var grayCode = function(n) {
    const result = [0];

    for (let i = 1; i <= n; i++) {
        const numToAdd = 1 << (i - 1);
        for (let j = result.length - 1; j >= 0; j--) {
            result.push(result[j] + numToAdd);
        }
    }

    return result;
};