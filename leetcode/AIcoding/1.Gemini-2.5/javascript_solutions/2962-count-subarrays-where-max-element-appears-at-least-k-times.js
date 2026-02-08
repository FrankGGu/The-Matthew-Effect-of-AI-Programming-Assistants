var countSubarrays = function(nums, k) {
    let maxVal = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    let left = 0;
    let count = 0; // count of maxVal in current window [left, right]
    let ans = 0;

    for (let right = 0; right < nums.length; right++) {
        if (nums[right] === maxVal) {
            count++;
        }

        // While the current window [left, right] has at least k occurrences of maxVal
        // we shrink the window from the left.
        // The 'left' pointer will eventually point to the first index such that
        // the window [left, right] has strictly less than k occurrences of maxVal.
        while (count >= k) {
            if (nums[left] === maxVal) {
                count--;
            }
            left++;
        }

        // At this point, 'left' is the smallest index such that the subarray nums[left...right]
        // contains less than k occurrences of maxVal.
        // This implies that any subarray starting from an index x (where 0 <= x < left)
        // and ending at 'right' will contain at least k occurrences of maxVal.
        // The number of such starting positions (0, 1, ..., left - 1) is 'left'.
        // We add this 'left' to our total count of valid subarrays.
        ans += left;
    }

    return ans;
};