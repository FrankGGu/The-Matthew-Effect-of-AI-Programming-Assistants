function minPairRemovalToSortArray(nums) {
    let n = nums.length;
    let count = 0;
    for (let i = 1; i < n; i++) {
        if (nums[i] < nums[i - 1]) {
            count++;
            nums[i] = nums[i - 1];
        }
    }
    return count;
}