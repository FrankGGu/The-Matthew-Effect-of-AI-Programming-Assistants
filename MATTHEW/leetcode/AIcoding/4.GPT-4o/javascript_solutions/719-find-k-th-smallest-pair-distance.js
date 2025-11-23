var smallestDistancePair = function(nums, k) {
    nums.sort((a, b) => a - b);

    const canFindKPairs = (distance) => {
        let count = 0, left = 0;
        for (let right = 0; right < nums.length; right++) {
            while (nums[right] - nums[left] > distance) {
                left++;
            }
            count += right - left;
        }
        return count >= k;
    };

    let left = 0, right = nums[nums.length - 1] - nums[0];
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canFindKPairs(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};