var maxSumOfThreeSubarrays = function(nums, k) {
    const n = nums.length;
    const sum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        sum[i + 1] = sum[i] + nums[i];
    }

    const left = new Array(n).fill(0);
    let total = sum[k] - sum[0];
    for (let i = k; i < n; i++) {
        const current = sum[i + 1] - sum[i + 1 - k];
        if (current > total) {
            left[i] = i + 1 - k;
            total = current;
        } else {
            left[i] = left[i - 1];
        }
    }

    const right = new Array(n).fill(0);
    right[n - k] = n - k;
    total = sum[n] - sum[n - k];
    for (let i = n - k - 1; i >= 0; i--) {
        const current = sum[i + k] - sum[i];
        if (current >= total) {
            right[i] = i;
            total = current;
        } else {
            right[i] = right[i + 1];
        }
    }

    let max = 0;
    const res = [0, 0, 0];
    for (let i = k; i <= n - 2 * k; i++) {
        const l = left[i - 1];
        const r = right[i + k];
        const current = (sum[l + k] - sum[l]) + (sum[i + k] - sum[i]) + (sum[r + k] - sum[r]);
        if (current > max) {
            max = current;
            res[0] = l;
            res[1] = i;
            res[2] = r;
        }
    }

    return res;
};