var minDifference = function(nums, queries) {
    const n = nums.length;
    const prefix = Array.from({ length: n + 1 }, () => new Array(101).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 1; j <= 100; j++) {
            prefix[i + 1][j] = prefix[i][j];
        }
        prefix[i + 1][nums[i]]++;
    }

    const result = [];
    for (const [l, r] of queries) {
        const current = [];
        for (let j = 1; j <= 100; j++) {
            if (prefix[r + 1][j] - prefix[l][j] > 0) {
                current.push(j);
            }
        }
        let minDiff = Infinity;
        for (let k = 1; k < current.length; k++) {
            minDiff = Math.min(minDiff, current[k] - current[k - 1]);
        }
        result.push(minDiff === Infinity ? -1 : minDiff);
    }
    return result;
};