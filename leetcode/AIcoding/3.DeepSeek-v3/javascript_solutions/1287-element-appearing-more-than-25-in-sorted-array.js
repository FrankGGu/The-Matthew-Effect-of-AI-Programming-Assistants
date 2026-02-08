var findSpecialInteger = function(arr) {
    const n = arr.length;
    const quarter = Math.floor(n / 4);

    for (let i = 0; i < n - quarter; i++) {
        if (arr[i] === arr[i + quarter]) {
            return arr[i];
        }
    }

    return -1;
};