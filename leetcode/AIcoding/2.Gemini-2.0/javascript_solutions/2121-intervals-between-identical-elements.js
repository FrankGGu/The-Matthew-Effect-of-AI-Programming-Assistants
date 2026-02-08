var getDistances = function(arr) {
    const n = arr.length;
    const result = new Array(n).fill(0);
    const map = new Map();

    for (let i = 0; i < n; i++) {
        const num = arr[i];
        if (!map.has(num)) {
            map.set(num, []);
        }
        map.get(num).push(i);
    }

    for (let i = 0; i < n; i++) {
        const num = arr[i];
        const indices = map.get(num);
        let distance = 0;
        for (const index of indices) {
            distance += Math.abs(index - i);
        }
        result[i] = distance;
    }

    return result;
};