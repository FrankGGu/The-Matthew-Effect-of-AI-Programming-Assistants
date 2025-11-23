var findBestValue = function(arr, target) {
    const calculateMutatedSum = (arr, value) => {
        let currentSum = 0;
        for (const num of arr) {
            currentSum += Math.min(num, value);
        }
        return currentSum;
    };

    let low = 0;
    let high = 100000; // Maximum possible value for arr[i] is 10^5. Any 'value' greater than this will result in the same sum as if 'value' was 10^5.
    let v_upper = 0; // Stores the smallest 'value' such that calculateMutatedSum(arr, value) >= target

    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        const currentSum = calculateMutatedSum(arr, mid);

        if (currentSum >= target) {
            v_upper = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    const sum_v_upper = calculateMutatedSum(arr, v_upper);
    const diff_v_upper = Math.abs(sum_v_upper - target);

    if (v_upper - 1 >= 0) {
        const sum_v_lower = calculateMutatedSum(arr, v_upper - 1);
        const diff_v_lower = Math.abs(sum_v_lower - target);

        // If diff_v_lower is less than diff_v_upper, v_upper - 1 is strictly better.
        // If diff_v_lower is equal to diff_v_upper, problem asks for the smallest such integer, so v_upper - 1 is preferred.
        if (diff_v_lower <= diff_v_upper) {
            return v_upper - 1;
        } else {
            return v_upper;
        }
    } else {
        // If v_upper is 0, then v_upper - 1 is negative and not a valid option.
        // So 0 is the only non-negative choice in this range.
        return v_upper;
    }
};