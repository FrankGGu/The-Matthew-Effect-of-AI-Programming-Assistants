var earliestSecondToMarkIndices = function(nums, changeIndices) {
    const n = nums.length;
    const m = changeIndices.length;
    let left = 1, right = m;
    let answer = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canMarkAll(mid)) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    function canMarkAll(s) {
        const lastOccurrence = new Array(n).fill(-1);
        for (let i = 0; i < s; i++) {
            const idx = changeIndices[i] - 1;
            if (idx >= 0 && idx < n) {
                lastOccurrence[idx] = i;
            }
        }
        for (let i = 0; i < n; i++) {
            if (lastOccurrence[i] === -1) {
                return false;
            }
        }
        let marked = 0;
        for (let i = 0; i < s; i++) {
            const idx = changeIndices[i] - 1;
            if (idx >= 0 && idx < n && lastOccurrence[idx] === i) {
                if (marked < nums[idx]) {
                    return false;
                }
                marked -= nums[idx];
            } else {
                marked++;
            }
        }
        return true;
    }

    return answer;
};