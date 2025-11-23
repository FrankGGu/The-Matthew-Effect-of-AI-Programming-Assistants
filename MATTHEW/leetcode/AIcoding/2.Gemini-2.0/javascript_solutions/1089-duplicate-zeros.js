var duplicateZeros = function(arr) {
    let n = arr.length;
    let i = 0;
    while (i < n) {
        if (arr[i] === 0) {
            for (let j = n - 1; j > i; j--) {
                arr[j] = arr[j - 1];
            }
            i++;
        }
        i++;
    }
};