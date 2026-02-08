var splitArray = function(nums) {
    const n = nums.length;
    if (n < 7) return false;

    const sum = new Array(n).fill(0);
    sum[0] = nums[0];
    for (let i = 1; i < n; i++) {
        sum[i] = sum[i - 1] + nums[i];
    }

    for (let j = 3; j < n - 3; j++) {
        for (let i = 1; i < j - 1; i++) {
            if (sum[i - 1] === sum[j - 1] - sum[i]) {
                for (let k = j + 2; k < n - 1; k++) {
                    if (sum[k - 1] - sum[j] === sum[n - 1] - sum[k]) {
                        if (sum[i - 1] === sum[k - 1] - sum[j]) return true;
                    }
                }
            }
        }
    }

    return false;
};