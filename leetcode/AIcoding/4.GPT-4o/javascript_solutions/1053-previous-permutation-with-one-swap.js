var prevPerms = function(arr) {
    let n = arr.length;
    let i = n - 2;

    while (i >= 0 && arr[i] <= arr[i + 1]) {
        i--;
    }

    if (i < 0) return arr.reverse();

    let j = n - 1;
    while (arr[j] >= arr[i]) {
        j--;
    }

    [arr[i], arr[j]] = [arr[j], arr[i]];

    const reversed = arr.slice(i + 1).reverse();
    for (let k = 0; k < reversed.length; k++) {
        arr[i + 1 + k] = reversed[k];
    }

    return arr;
};