function minAdjSwapsForKConsecutiveOnes(nums, k) {
    const n = nums.length;
    const pos = [];
    for (let i = 0; i < n; ++i) {
        if (nums[i] === 1) {
            pos.push(i);
        }
    }
    const m = pos.length;
    let res = Number.MAX_VALUE;
    for (let i = 0; i + k - 1 < m; ++i) {
        const target = pos[i + k - 1];
        const mid = i + (k - 1) >> 1;
        let swaps = 0;
        for (let j = i; j <= i + k - 1; ++j) {
            swaps += Math.abs(pos[j] - pos[mid]);
        }
        res = Math.min(res, swaps);
    }
    return res;
}