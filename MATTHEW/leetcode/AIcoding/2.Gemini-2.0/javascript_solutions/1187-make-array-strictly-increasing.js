var makeArrayIncreasing = function(arr1, arr2) {
    arr2.sort((a, b) => a - b);
    const dp = new Map();

    function find(i, prev) {
        if (i === arr1.length) {
            return 0;
        }

        const key = `${i}-${prev}`;
        if (dp.has(key)) {
            return dp.get(key);
        }

        let cost = Infinity;

        if (arr1[i] > prev) {
            cost = Math.min(cost, find(i + 1, arr1[i]));
        }

        let replacementIndex = -1;
        let low = 0;
        let high = arr2.length - 1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (arr2[mid] > prev) {
                replacementIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        if (replacementIndex !== -1) {
            cost = Math.min(cost, 1 + find(i + 1, arr2[replacementIndex]));
        }

        dp.set(key, cost);
        return cost;
    }

    const result = find(0, -1);
    return result === Infinity ? -1 : result;
};