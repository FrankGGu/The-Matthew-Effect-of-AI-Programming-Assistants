var minimumReplacement = function(nums) {
    let n = nums.length;
    let replacements = 0;
    let last = nums[n - 1];

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] <= last) {
            last = nums[i];
        } else {
            // Calculate how many parts nums[i] needs to be broken into.
            // To minimize replacements, we want each part to be as large as possible,
            // but not exceeding `last`.
            // The number of parts `k` is `ceil(nums[i] / last)`.
            let k = Math.ceil(nums[i] / last);

            // The number of replacements needed for nums[i] is `k - 1`.
            replacements += (k - 1);

            // After breaking nums[i] into `k` parts, the smallest possible value among these parts
            // will be `floor(nums[i] / k)`. This value becomes the new `last` for elements to its left.
            last = Math.floor(nums[i] / k);
        }
    }

    return replacements;
};