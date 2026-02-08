function minimumOperations(s, k) {
    const n = s.length;
    let operations = 0;

    for (let i = 0; i < k; i++) {
        const count = new Array(26).fill(0);
        for (let j = i; j < n; j += k) {
            count[s.charCodeAt(j) - 'a'.charCodeAt(0)]++;
        }
        const maxCount = Math.max(...count);
        operations += (n / k) - maxCount;
    }

    return operations;
}