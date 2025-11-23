var makeArrayIncreasing = function(arr1, arr2) {
    const arr2_sorted = [...new Set(arr2)].sort((a, b) => a - b);

    const bisectRight = (arr, val) => {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] <= val) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    let dp = new Map();
    dp.set(-1, 0);

    for (const num1 of arr1) {
        let new_dp = new Map();

        for (const [prev_val, ops] of dp.entries()) {
            if (num1 > prev_val) {
                if (!new_dp.has(num1) || ops < new_dp.get(num1)) {
                    new_dp.set(num1, ops);
                }
            }

            const idx = bisectRight(arr2_sorted, prev_val);
            if (idx < arr2_sorted.length) {
                const replacement_val = arr2_sorted[idx];
                if (!new_dp.has(replacement_val) || (ops + 1) < new_dp.get(replacement_val)) {
                    new_dp.set(replacement_val, ops + 1);
                }
            }
        }

        dp = new_dp;

        if (dp.size === 0) {
            return -1;
        }
    }

    let min_ops = Infinity;
    for (const ops of dp.values()) {
        min_ops = Math.min(min_ops, ops);
    }

    return min_ops === Infinity ? -1 : min_ops;
};