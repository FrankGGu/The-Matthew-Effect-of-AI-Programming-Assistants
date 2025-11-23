var earliestSecondToMarkIndices = function(nums, changeIndices) {
    const n = nums.length;
    const m = changeIndices.length;

    function check(time) {
        const lastOccurrence = new Array(n + 1).fill(-1);
        for (let i = 0; i < time; i++) {
            lastOccurrence[changeIndices[i]] = i;
        }

        let marked = new Array(n + 1).fill(false);
        let operations = 0;

        for (let i = 0; i < time; i++) {
            const index = changeIndices[i];
            if (lastOccurrence[index] === i) {
                if (nums[index - 1] <= time - operations - 1) {
                    operations += nums[index - 1];
                    marked[index] = true;
                } else {
                    operations++;
                }
            } else {
                operations++;
            }
        }

        for (let i = 1; i <= n; i++) {
            if (!marked[i]) {
                return false;
            }
        }

        return true;
    }

    let left = 1;
    let right = m;
    let result = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (check(mid)) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
};