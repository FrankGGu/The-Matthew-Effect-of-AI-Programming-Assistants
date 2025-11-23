var decode = function(encoded, first) {
    const n = encoded.length + 1;
    const arr = new Array(n);
    arr[0] = first;
    for (let i = 0; i < encoded.length; i++) {
        arr[i + 1] = arr[i] ^ encoded[i];
    }
    return arr;
};