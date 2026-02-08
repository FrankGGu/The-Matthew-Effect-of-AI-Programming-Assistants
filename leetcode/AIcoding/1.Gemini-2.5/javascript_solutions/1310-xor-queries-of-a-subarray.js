var xorQueries = function(arr, queries) {
    const n = arr.length;
    const prefixXOR = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixXOR[i + 1] = prefixXOR[i] ^ arr[i];
    }

    const results = [];
    for (const query of queries) {
        const L = query[0];
        const R = query[1];
        results.push(prefixXOR[R + 1] ^ prefixXOR[L]);
    }

    return results;
};