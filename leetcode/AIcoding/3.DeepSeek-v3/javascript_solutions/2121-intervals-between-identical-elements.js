var getDistances = function(arr) {
    const map = {};
    const n = arr.length;
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (!map[arr[i]]) {
            map[arr[i]] = [];
        }
        map[arr[i]].push(i);
    }

    for (const key in map) {
        const indices = map[key];
        const m = indices.length;
        const prefix = new Array(m + 1).fill(0);

        for (let i = 0; i < m; i++) {
            prefix[i + 1] = prefix[i] + indices[i];
        }

        for (let i = 0; i < m; i++) {
            const current = indices[i];
            const left = current * i - prefix[i];
            const right = (prefix[m] - prefix[i + 1]) - current * (m - i - 1);
            result[current] = left + right;
        }
    }

    return result;
};