function countNonDecreasingSubarrays(nums, k) {
    let n = nums.length;
    let left = 0;
    let result = 0;
    let cnt = new Array(n).fill(0);

    for (let right = 0; right < n; right++) {
        if (right > 0 && nums[right] < nums[right - 1]) {
            left = right;
        }

        cnt[right] = right - left + 1;

        if (right > 0 && nums[right] < nums[right - 1] + k) {
            cnt[right] = Math.min(cnt[right], right - left + 1);
        }

        result += cnt[right];
    }

    return result;
}