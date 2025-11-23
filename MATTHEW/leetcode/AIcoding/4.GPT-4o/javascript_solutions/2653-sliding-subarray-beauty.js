var getSubarrayBeauty = function(nums, k, x) {
    const n = nums.length;
    const result = new Array(n - k + 1).fill(0);
    const frequency = new Array(101).fill(0);

    for (let i = 0; i < k; i++) {
        frequency[nums[i] + 50]++;
    }

    for (let i = 0; i <= n - k; i++) {
        let count = 0;
        for (let j = 0; j < 101; j++) {
            if (frequency[j] > 0) {
                count += frequency[j];
                if (count >= x) {
                    result[i] = j - 50;
                    break;
                }
            }
        }
        if (i + k < n) {
            frequency[nums[i] + 50]--;
            frequency[nums[i + k] + 50]++;
        }
    }

    return result;
};