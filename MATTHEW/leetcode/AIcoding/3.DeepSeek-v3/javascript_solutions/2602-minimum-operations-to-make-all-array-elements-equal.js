var minOperations = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    const res = [];
    for (const q of queries) {
        let left = 0, right = n - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (nums[mid] < q) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        const sumLess = q * left - prefix[left];
        const sumGreater = (prefix[n] - prefix[left]) - q * (n - left);
        res.push(sumLess + sumGreater);
    }
    return res;
};