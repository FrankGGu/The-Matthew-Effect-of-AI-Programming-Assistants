var smallestDivisor = function(nums, threshold) {
    let left = 1;
    let right = Math.max(...nums);
    let ans = right;

    while (left <= right) {
        let mid = Math.floor(left + (right - left) / 2);
        let currentSum = 0;
        for (let i = 0; i < nums.length; i++) {
            currentSum += Math.ceil(nums[i] / mid);
        }

        if (currentSum <= threshold) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};