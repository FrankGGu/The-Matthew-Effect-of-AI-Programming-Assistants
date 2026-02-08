var xorQueries = function(arr, queries) {
    const n = arr.length;
    const prefixXor = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ arr[i];
    }

    const result = [];
    for (const [l, r] of queries) {
        result.push(prefixXor[r + 1] ^ prefixXor[l]);
    }

    return result;
};