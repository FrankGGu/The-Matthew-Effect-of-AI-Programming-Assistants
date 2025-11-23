function specialArray(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    for (let i = 0; i <= n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (nums[j] >= i) {
                count++;
            }
        }
        if (count === i) {
            return i;
        }
    }
    return 0;
}