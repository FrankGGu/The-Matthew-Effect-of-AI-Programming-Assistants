var sumOfDistances = function(arr) {
    const n = arr.length;
    const map = new Map();
    for (let i = 0; i < n; i++) {
        if (!map.has(arr[i])) {
            map.set(arr[i], []);
        }
        map.get(arr[i]).push(i);
    }

    const result = new Array(n).fill(0);

    for (const [key, indices] of map) {
        const m = indices.length;
        let prefixSum = 0;
        for (let i = 0; i < m; i++) {
            prefixSum += indices[i];
        }

        for (let i = 0; i < m; i++) {
            prefixSum -= indices[i];
            result[indices[i]] = indices[i] * i - (prefixSum - indices[i] * (m - i - 1));
        }
    }

    return result;
};