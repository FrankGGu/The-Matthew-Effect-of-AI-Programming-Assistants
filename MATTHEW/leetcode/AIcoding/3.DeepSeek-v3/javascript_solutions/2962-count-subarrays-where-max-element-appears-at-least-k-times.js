var countSubarrays = function(nums, k) {
    const max = Math.max(...nums);
    let left = 0, right = 0, count = 0, result = 0;
    const n = nums.length;

    while (right < n) {
        if (nums[right] === max) {
            count++;
        }

        while (count >= k) {
            result += n - right;
            if (nums[left] === max) {
                count--;
            }
            left++;
        }

        right++;
    }

    return result;
};