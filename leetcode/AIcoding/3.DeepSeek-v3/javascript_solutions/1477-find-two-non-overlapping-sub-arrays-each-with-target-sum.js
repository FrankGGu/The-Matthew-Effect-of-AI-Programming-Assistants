var minSumOfLengths = function(arr, target) {
    const n = arr.length;
    const prefix = new Array(n + 1).fill(Infinity);
    let sum = 0;
    let left = 0;
    let minLen = Infinity;
    let result = Infinity;
    const sumMap = new Map();
    sumMap.set(0, -1);

    for (let right = 0; right < n; right++) {
        sum += arr[right];
        sumMap.set(sum, right);
    }

    sum = 0;
    for (let right = 0; right < n; right++) {
        sum += arr[right];
        if (sumMap.has(sum - target)) {
            const left = sumMap.get(sum - target);
            const currentLen = right - left;
            if (left >= 0 && prefix[left] !== Infinity) {
                result = Math.min(result, prefix[left] + currentLen);
            }
            minLen = Math.min(minLen, currentLen);
        }
        prefix[right + 1] = minLen;
    }

    return result === Infinity ? -1 : result;
};