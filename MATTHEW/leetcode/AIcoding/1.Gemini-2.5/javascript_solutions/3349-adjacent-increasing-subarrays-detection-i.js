var canBeSplitIntoTwoIncreasingSubarrays = function(nums) {
    const n = nums.length;

    if (n < 2) {
        return false;
    }

    const prefixIncreasing = new Array(n).fill(false);
    prefixIncreasing[0] = true;
    for (let i = 1; i < n; i++) {
        prefixIncreasing[i] = prefixIncreasing[i - 1] && (nums[i - 1] < nums[i]);
    }

    const suffixIncreasing = new Array(n).fill(false);
    suffixIncreasing[n - 1] = true;
    for (let i = n - 2; i >= 0; i--) {
        suffixIncreasing[i] = suffixIncreasing[i + 1] && (nums[i] < nums[i + 1]);
    }

    for (let i = 0; i < n - 1; i++) {
        if (prefixIncreasing[i] && suffixIncreasing[i + 1]) {
            return true;
        }
    }

    return false;
};