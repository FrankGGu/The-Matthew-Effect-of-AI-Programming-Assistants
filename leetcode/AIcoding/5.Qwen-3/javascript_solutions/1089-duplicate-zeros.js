function duplicateZeros(arr) {
    let i = 0;
    while (i < arr.length) {
        if (arr[i] === 0) {
            for (let j = arr.length - 1; j > i; j--) {
                arr[j] = arr[j - 1];
            }
            i += 2;
        } else {
            i++;
        }
    }
}