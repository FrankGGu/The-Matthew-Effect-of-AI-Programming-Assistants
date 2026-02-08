var constructArray = function(arr) {
    const n = arr.length;
    const result = new Array(n);
    for (let i = 0; i < n; i++) {
        result[i] = 0;
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                result[i] |= arr[j];
            }
        }
    }
    return result;
};