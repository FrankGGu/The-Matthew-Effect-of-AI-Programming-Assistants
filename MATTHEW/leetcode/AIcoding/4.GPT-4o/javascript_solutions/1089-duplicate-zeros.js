function duplicateZeros(arr) {
    let zeros = 0;
    let length = arr.length;

    for (let i = 0; i < length; i++) {
        if (arr[i] === 0) {
            zeros++;
        }
    }

    for (let i = length - 1, j = length + zeros - 1; i >= 0; i--) {
        if (j < length) {
            arr[j] = arr[i];
        }
        if (arr[i] === 0) {
            j--;
            if (j < length) {
                arr[j] = 0;
            }
        }
        j--;
    }
}