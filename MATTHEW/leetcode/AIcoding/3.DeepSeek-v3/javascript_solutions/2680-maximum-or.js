var maximumOr = function(nums, k) {
    let prefix = new Array(nums.length + 1).fill(0);
    let suffix = new Array(nums.length + 1).fill(0);

    for (let i = 0; i < nums.length; i++) {
        prefix[i + 1] = prefix[i] | nums[i];
    }

    for (let i = nums.length - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1] | nums[i];
    }

    let max = 0;
    for (let i = 0; i < nums.length; i++) {
        let current = nums[i] << k;
        let or = prefix[i] | current | suffix[i + 1];
        if (or > max) {
            max = or;
        }
    }

    return max;
};