var earliestSecondToMarkIndices = function(nums, changeIndices) {
    const n = nums.length;
    const m = changeIndices.length;

    function check(time) {
        let last = new Array(n + 1).fill(-1);
        for (let i = 0; i < time; i++) {
            last[changeIndices[i]] = i;
        }

        for (let i = 1; i <= n; i++) {
            if (last[i] === -1) return false;
        }

        let marked = new Array(n + 1).fill(false);
        let curTime = 0;
        let ops = 0;
        for (let i = 0; i < time; i++) {
            let idx = changeIndices[i];
            if (last[idx] === i) {
                if (nums[idx - 1] <= ops) {
                    ops -= nums[idx - 1];
                    marked[idx] = true;
                } else {
                    curTime++;
                }
            } else {
                ops++;
            }
        }

        for (let i = 1; i <= n; i++) {
            if (!marked[i]) return false;
        }

        return true;
    }

    let left = 1;
    let right = m;
    let ans = -1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (check(mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};