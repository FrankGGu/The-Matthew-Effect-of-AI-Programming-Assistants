var decode = function(encoded, first) {
    const n = encoded.length;
    const arr = new Array(n + 1);
    arr[0] = first;

    for (let i = 0; i < n; i++) {
        arr[i + 1] = arr[i] ^ encoded[i];
    }

    return arr;
};