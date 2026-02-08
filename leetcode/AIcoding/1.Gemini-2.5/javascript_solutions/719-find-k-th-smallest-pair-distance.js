var smallestDistancePair = function(nums, k) {
    nums.sort((a, b) => a - b);

    const n = nums.length;
    let low = 0;
    let high = nums[n - 1] - nums[0];
    let ans = 0;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        let count = 0;
        let left = 0;
        for (let right = 0; right < n; right++) {
            while (nums[right] - nums[left] > mid) {
                left++;
            }
            count += (right - left);
        }

        if (count >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};