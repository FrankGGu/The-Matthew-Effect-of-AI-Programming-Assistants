function countSubarrays(nums, k) {
    let count = 0;
    let n = nums.length;
    let left = 0, right = 0;
    let greater = 0, less = 0;

    while (right < n) {
        if (nums[right] < k) {
            less++;
        } else if (nums[right] > k) {
            greater++;
        }

        while (greater > 0) {
            if (nums[left] < k) {
                less--;
            } else if (nums[left] > k) {
                greater--;
            }
            left++;
        }

        count += right - left + 1;
        right++;
    }

    return count;
}