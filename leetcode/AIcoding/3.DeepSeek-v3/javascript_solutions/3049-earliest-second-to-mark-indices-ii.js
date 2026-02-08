var earliestSecondToMarkIndices = function(nums, changeIndices) {
    const n = nums.length;
    const m = changeIndices.length;
    let left = 0, right = m;
    let result = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canMark(mid)) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    function canMark(s) {
        const lastOccurrence = new Array(n).fill(-1);
        for (let i = 0; i < s; i++) {
            const idx = changeIndices[i] - 1;
            if (idx >= 0 && idx < n) {
                lastOccurrence[idx] = i;
            }
        }
        for (let i = 0; i < n; i++) {
            if (lastOccurrence[i] === -1) return false;
        }

        let operations = 0;
        for (let i = 0; i < s; i++) {
            const idx = changeIndices[i] - 1;
            if (i === lastOccurrence[idx]) {
                if (operations < nums[idx]) {
                    return false;
                }
                operations -= nums[idx];
            } else {
                operations++;
            }
        }
        return true;
    }

    return result === -1 ? -1 : result;
};