var duplicateZeros = function(arr) {
    const n = arr.length;
    let i = 0;
    while (i < n) {
        if (arr[i] === 0) {
            arr.splice(i, 0, 0);
            arr.pop();
            i += 2;
        } else {
            i++;
        }
    }
};