var minCapability = function(nums, k) {
    let left = Math.min(...nums);
    let right = Math.max(...nums);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canRob(mid, nums, k)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};

function canRob(maxCap, nums, k) {
    let count = 0;
    let i = 0;
    while (i < nums.length) {
        if (nums[i] <= maxCap) {
            count++;
            i += 2;
        } else {
            i++;
        }
        if (count >= k) return true;
    }
    return count >= k;
}