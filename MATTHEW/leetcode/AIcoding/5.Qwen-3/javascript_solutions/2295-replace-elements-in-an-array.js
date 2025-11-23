function replaceElements(nums) {
    let max = -1;
    for (let i = nums.length - 1; i >= 0; i--) {
        let temp = nums[i];
        nums[i] = max;
        max = Math.max(max, temp);
    }
    return nums;
}