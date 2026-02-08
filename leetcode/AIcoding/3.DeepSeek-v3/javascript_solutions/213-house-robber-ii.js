var rob = function(nums) {
    if (nums.length === 1) return nums[0];

    function robRange(start, end) {
        let prev = 0, curr = 0;
        for (let i = start; i <= end; i++) {
            let temp = Math.max(curr, prev + nums[i]);
            prev = curr;
            curr = temp;
        }
        return curr;
    }

    return Math.max(robRange(0, nums.length - 2), robRange(1, nums.length - 1));
};