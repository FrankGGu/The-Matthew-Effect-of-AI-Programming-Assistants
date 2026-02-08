function maximizeMinimum(nums) {
    let left = 0, right = Math.min(...nums) + 1;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canAchieve(nums, mid)) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left - 1;
}

function canAchieve(nums, target) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] >= target) {
            count++;
            i++; // Skip the next element
        }
    }
    return count >= Math.ceil(nums.length / 2);
}