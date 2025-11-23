var maximumOr = function(nums, k) {
    let n = nums.length;
    let prefixOr = new Array(n).fill(0);
    let suffixOr = new Array(n).fill(0);

    prefixOr[0] = 0;
    for (let i = 1; i < n; i++) {
        prefixOr[i] = prefixOr[i - 1] | nums[i - 1];
    }

    suffixOr[n - 1] = 0;
    for (let i = n - 2; i >= 0; i--) {
        suffixOr[i] = suffixOr[i + 1] | nums[i + 1];
    }

    let maxOr = 0;
    for (let i = 0; i < n; i++) {
        maxOr = Math.max(maxOr, prefixOr[i] | (nums[i] * (2 ** k)) | suffixOr[i]);
    }

    return maxOr;
};