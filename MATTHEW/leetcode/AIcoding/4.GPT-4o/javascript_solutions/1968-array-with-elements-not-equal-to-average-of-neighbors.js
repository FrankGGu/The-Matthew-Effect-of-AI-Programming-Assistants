function rearrangeArray(nums) {
    const result = [];
    const n = nums.length;
    nums.sort((a, b) => a - b);

    let left = 0, right = Math.ceil(n / 2);
    while (left < Math.ceil(n / 2) || right < n) {
        if (left < Math.ceil(n / 2)) {
            result.push(nums[left++]);
        }
        if (right < n) {
            result.push(nums[right++]);
        }
    }

    return result;
}