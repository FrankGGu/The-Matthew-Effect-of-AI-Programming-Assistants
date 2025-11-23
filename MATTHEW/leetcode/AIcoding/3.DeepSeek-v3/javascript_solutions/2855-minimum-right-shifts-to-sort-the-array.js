var minimumRightShifts = function(nums) {
    const n = nums.length;
    let pivot = 0;
    let count = 0;

    for (let i = 1; i < n; i++) {
        if (nums[i - 1] > nums[i]) {
            pivot = i;
            count++;
        }
    }

    if (count > 1) return -1;
    if (pivot === 0) return 0;
    if (nums[n - 1] <= nums[0]) return n - pivot;
    return -1;
};