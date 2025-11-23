function minSumOfLengths(arr, target) {
    const n = arr.length;
    const prefixSum = new Map();
    let sum = 0;
    let minLength = Array(n).fill(Infinity);

    for (let i = 0; i < n; i++) {
        sum += arr[i];
        if (sum === target) {
            minLength[i] = i + 1;
        }
        if (prefixSum.has(sum - target)) {
            const startIndex = prefixSum.get(sum - target);
            minLength[i] = Math.min(minLength[i], i - startIndex);
        }
        prefixSum.set(sum, i);
    }

    let res = Infinity;
    sum = 0;

    for (let i = 0; i < n; i++) {
        sum += arr[i];
        if (sum === target) {
            res = Math.min(res, minLength[i] + (i + 1 < n ? minLength[i + 1] : Infinity));
        }
        if (prefixSum.has(sum - target)) {
            const startIndex = prefixSum.get(sum - target);
            if (startIndex < i) {
                res = Math.min(res, minLength[startIndex] + (i + 1 < n ? minLength[i + 1] : Infinity));
            }
        }
    }

    return res === Infinity ? -1 : res;
}