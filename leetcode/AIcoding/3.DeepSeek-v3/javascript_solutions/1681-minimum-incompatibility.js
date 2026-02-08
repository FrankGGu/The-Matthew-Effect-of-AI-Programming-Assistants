var minimumIncompatibility = function(nums, k) {
    const n = nums.length;
    const size = n / k;
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
        if (freq[num] > k) return -1;
    }

    const memo = {};

    function backtrack(used, groups) {
        if (groups === k) return 0;
        const key = used.join('');
        if (memo[key] !== undefined) return memo[key];

        let minIncomp = Infinity;
        let start = 0;
        while (start < n && used[start]) start++;

        const subset = [];
        function generateSubsets(pos) {
            if (subset.length === size) {
                let incomp = Math.max(...subset) - Math.min(...subset);
                const nextUsed = [...used];
                for (const num of subset) {
                    const idx = nums.indexOf(num, start);
                    nextUsed[idx] = 1;
                }
                const res = backtrack(nextUsed, groups + 1);
                if (res !== -1) {
                    minIncomp = Math.min(minIncomp, incomp + res);
                }
                return;
            }

            for (let i = pos; i < n; i++) {
                if (!used[i] && (subset.length === 0 || nums[i] > subset[subset.length - 1])) {
                    subset.push(nums[i]);
                    generateSubsets(i + 1);
                    subset.pop();
                }
            }
        }

        generateSubsets(start);
        memo[key] = minIncomp === Infinity ? -1 : minIncomp;
        return memo[key];
    }

    return backtrack(new Array(n).fill(0), 0);
};