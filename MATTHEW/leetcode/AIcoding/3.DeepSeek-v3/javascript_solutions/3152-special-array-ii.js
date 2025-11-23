var isArraySpecial = function(nums, queries) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1];
        if (nums[i] % 2 === nums[i - 1] % 2) {
            prefix[i]++;
        }
    }

    const result = [];
    for (const [x, y] of queries) {
        if (x === y) {
            result.push(true);
        } else {
            const diff = prefix[y] - prefix[x];
            result.push(diff === 0);
        }
    }
    return result;
};