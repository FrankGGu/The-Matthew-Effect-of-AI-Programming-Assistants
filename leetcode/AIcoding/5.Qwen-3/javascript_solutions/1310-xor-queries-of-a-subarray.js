function xorQueries(arr, queries) {
    const prefix = new Array(arr.length + 1).fill(0);
    for (let i = 0; i < arr.length; i++) {
        prefix[i + 1] = prefix[i] ^ arr[i];
    }
    const result = new Array(queries.length);
    for (let i = 0; i < queries.length; i++) {
        const [l, r] = queries[i];
        result[i] = prefix[r + 1] ^ prefix[l];
    }
    return result;
}