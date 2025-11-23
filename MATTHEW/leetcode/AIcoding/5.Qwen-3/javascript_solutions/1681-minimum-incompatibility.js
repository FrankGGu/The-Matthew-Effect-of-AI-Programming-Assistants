function minIncompatibility(nums, k) {
    const n = nums.length;
    if (k === n) return Math.max(...nums);

    const total = Math.floor(n / k);
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        const count = binCount(mask);
        if (count === total) continue;

        const current = [];
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                current.push(nums[i]);
            }
        }

        const used = new Array(n).fill(false);
        const backtrack = (start, path) => {
            if (path.length === total) {
                const newMask = mask;
                for (const num of path) {
                    for (let i = 0; i < n; i++) {
                        if (nums[i] === num && !used[i]) {
                            used[i] = true;
                            newMask |= (1 << i);
                            break;
                        }
                    }
                }
                dp[newMask] = Math.min(dp[newMask], dp[mask] + Math.max(...path));
                return;
            }

            for (let i = start; i < current.length; i++) {
                if (used[i]) continue;
                used[i] = true;
                backtrack(i + 1, [...path, current[i]]);
                used[i] = false;
            }
        };

        backtrack(0, []);
    }

    return dp[(1 << n) - 1];
}

function binCount(mask) {
    let count = 0;
    while (mask) {
        count += mask & 1;
        mask >>= 1;
    }
    return count;
}