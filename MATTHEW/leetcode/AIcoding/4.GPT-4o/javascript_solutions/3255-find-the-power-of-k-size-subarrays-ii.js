var countSubarrays = function(nums, k) {
    let count = 0;
    let product = 1;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        product *= nums[right];

        while (left <= right && product >= k) {
            product /= nums[left];
            left++;
        }

        count += right - left + 1;
    }

    return count;
};