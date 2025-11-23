var distance = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    const map = new Map();

    for (let i = 0; i < n; i++) {
        if (!map.has(nums[i])) {
            map.set(nums[i], []);
        }
        map.get(nums[i]).push(i);
    }

    for (const [num, indices] of map.entries()) {
        const m = indices.length;
        if (m === 1) continue;

        let prefixSum = new Array(m).fill(0);
        prefixSum[0] = indices[0];
        for (let i = 1; i < m; i++) {
            prefixSum[i] = prefixSum[i - 1] + indices[i];
        }

        for (let i = 0; i < m; i++) {
            const current = indices[i];
            const left = i * current - (i > 0 ? prefixSum[i - 1] : 0);
            const right = (prefixSum[m - 1] - prefixSum[i]) - (m - 1 - i) * current;
            result[current] = left + right;
        }
    }

    return result;
};