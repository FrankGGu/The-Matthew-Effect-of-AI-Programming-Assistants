function maxMarkedIndices(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let i = 0;
    let j = (n + 1) >> 1;
    let count = 0;
    while (i < (n + 1) >> 1 && j < n) {
        if (nums[i] * 2 <= nums[j]) {
            count++;
            i++;
        }
        j++;
    }
    return count;
}