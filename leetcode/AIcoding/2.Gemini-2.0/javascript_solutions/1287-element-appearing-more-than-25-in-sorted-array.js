var findSpecialInteger = function(arr) {
    const n = arr.length;
    const threshold = n / 4;
    let count = 1;
    for (let i = 1; i < n; i++) {
        if (arr[i] === arr[i - 1]) {
            count++;
            if (count > threshold) {
                return arr[i];
            }
        } else {
            count = 1;
        }
    }
    return arr[0];
};