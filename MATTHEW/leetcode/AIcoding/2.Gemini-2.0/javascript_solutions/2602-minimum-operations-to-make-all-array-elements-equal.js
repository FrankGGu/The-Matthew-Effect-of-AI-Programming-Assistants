var minOperations = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const result = [];
    for (const query of queries) {
        let left = 0;
        let right = n - 1;
        let index = -1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (nums[mid] < query) {
                left = mid + 1;
            } else {
                index = mid;
                right = mid - 1;
            }
        }

        if (index === -1) {
            index = n;
        }

        let operations = 0;
        if (index > 0) {
            operations += query * index - prefixSum[index];
        }
        if (index < n) {
            operations += prefixSum[n] - prefixSum[index] - query * (n - index);
        }
        result.push(operations);
    }

    return result;
};