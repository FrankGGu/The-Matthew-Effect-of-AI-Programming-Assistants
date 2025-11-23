function checkSortedAndRotated(nums) {
    let count = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < nums[i - 1]) {
            count++;
            if (count > 1) return false;
        }
    }
    return count <= 1;
}