function rob(nums) {
    if (nums.length === 1) return nums[0];
    if (nums.length === 2) return Math.max(nums[0], nums[1]);

    function helper(subNums) {
        let prev = 0, curr = 0;
        for (let num of subNums) {
            let temp = curr;
            curr = Math.max(curr, prev + num);
            prev = temp;
        }
        return curr;
    }

    return Math.max(helper(nums.slice(1)), helper(nums.slice(0, nums.length - 1)));
}