var minimumReplacement = function(nums) {
    let n = nums.length;
    let count = 0;
    let last = nums[n - 1];

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] > last) {
            let k = Math.ceil(nums[i] / last);
            count += k - 1;
            last = Math.floor(nums[i] / k);
        } else {
            last = nums[i];
        }
    }

    return count;
};