var makeArrayIncreasing = function(arr1, arr2) {
    arr2.sort((a, b) => a - b);
    const memo = new Map();

    function dp(i, prev) {
        if (i === arr1.length) return 0;
        const key = `${i},${prev}`;
        if (memo.has(key)) return memo.get(key);

        let res = Infinity;
        if (arr1[i] > prev) {
            res = dp(i + 1, arr1[i]);
        }

        let idx = binarySearch(arr2, prev);
        if (idx < arr2.length) {
            const cost = 1 + dp(i + 1, arr2[idx]);
            res = Math.min(res, cost);
        }

        memo.set(key, res);
        return res;
    }

    function binarySearch(arr, target) {
        let left = 0, right = arr.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (arr[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    const result = dp(0, -Infinity);
    return result === Infinity ? -1 : result;
};