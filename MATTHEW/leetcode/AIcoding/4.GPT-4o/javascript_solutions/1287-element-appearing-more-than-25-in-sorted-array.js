var findSpecialInteger = function(arr) {
    let n = arr.length;
    let threshold = n / 4;

    for (let i = 0; i < n; i++) {
        if (i > 0 && arr[i] === arr[i - 1]) continue;
        let count = 0;
        while (i + count < n && arr[i + count] === arr[i]) {
            count++;
        }
        if (count > threshold) {
            return arr[i];
        }
        i += count - 1;
    }
    return -1;
};