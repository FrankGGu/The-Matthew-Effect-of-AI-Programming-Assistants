function maxSumTwoNoOverlap(nums, l) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += nums[i];
        if (i < l) {
            left[i] = sum;
        } else {
            left[i] = sum - nums[i - l];
            sum -= nums[i - l];
        }
    }

    sum = 0;
    for (let i = n - 1; i >= 0; i--) {
        sum += nums[i];
        if (i > n - l - 1) {
            right[i] = sum;
        } else {
            right[i] = sum - nums[i + l];
            sum -= nums[i + l];
        }
    }

    let result = 0;
    for (let i = l; i < n - l; i++) {
        let maxLeft = 0;
        for (let j = 0; j < i - l + 1; j++) {
            maxLeft = Math.max(maxLeft, left[j]);
        }
        let maxRight = 0;
        for (let j = n - 1; j > i + l - 1; j--) {
            maxRight = Math.max(maxRight, right[j]);
        }
        result = Math.max(result, left[i] + maxRight);
        result = Math.max(result, right[i] + maxLeft);
    }

    return result;
}