var constructArray = function(n, k) {
    let result = [];
    for (let i = 1; i <= n; i++) {
        result.push(i);
    }

    for (let i = 0; i < k; i++) {
        if (i % 2 === 0) {
            result[i] = Math.floor(i / 2) + 1;
        } else {
            result[i] = n - Math.floor(i / 2);
        }
    }

    return result;
};