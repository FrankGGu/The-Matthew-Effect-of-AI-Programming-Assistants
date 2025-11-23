var subarrayXorQueries = function(arr, queries) {
    const n = arr.length;
    const prefixXor = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ arr[i];
    }

    const result = [];
    for (const query of queries) {
        const start = query[0];
        const end = query[1];
        result.push(prefixXor[end + 1] ^ prefixXor[start]);
    }

    return result;
};