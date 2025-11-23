function distinctAverages(nums) {
    nums.sort((a, b) => a - b);
    const set = new Set();
    let left = 0;
    let right = nums.length - 1;
    while (left < right) {
        const average = (nums[left] + nums[right]) / 2;
        set.add(average);
        left++;
        right--;
    }
    return set.size;
}