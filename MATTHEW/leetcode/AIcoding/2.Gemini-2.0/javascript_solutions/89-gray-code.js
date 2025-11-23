var grayCode = function(n) {
    if (n === 0) {
        return [0];
    }

    const result = [0, 1];

    for (let i = 2; i <= n; i++) {
        const len = result.length;
        for (let j = len - 1; j >= 0; j--) {
            result.push(result[j] + len);
        }
    }

    return result;
};