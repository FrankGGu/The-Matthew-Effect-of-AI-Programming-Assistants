var xorQueries = function(arr, queries) {
    const n = arr.length;
    const prefixXor = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ arr[i];
    }

    const result = [];
    for (const query of queries) {
        const left = query[0];
        const right = query[1];
        result.push(prefixXor[right + 1] ^ prefixXor[left]);
    }

    return result;
};