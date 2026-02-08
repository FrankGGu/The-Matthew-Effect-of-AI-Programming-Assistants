function countTriplets(arr) {
    const n = arr.length;
    const prefixXor = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ arr[i];
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const xor = prefixXor[j + 1] ^ prefixXor[i];
            for (let k = 0; k < n; k++) {
                if ((prefixXor[k + 1] ^ xor) === 0) {
                    count++;
                }
            }
        }
    }

    return count;
}