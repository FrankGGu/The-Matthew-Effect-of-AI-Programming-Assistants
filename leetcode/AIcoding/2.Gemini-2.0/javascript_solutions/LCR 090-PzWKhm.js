var rob = function(nums) {
    if (nums.length === 0) return 0;
    if (nums.length === 1) return nums[0];
    if (nums.length === 2) return Math.max(nums[0], nums[1]);

    function helper(arr) {
        let rob1 = 0;
        let rob2 = 0;

        for (let i = 0; i < arr.length; i++) {
            let temp = Math.max(rob1 + arr[i], rob2);
            rob1 = rob2;
            rob2 = temp;
        }

        return rob2;
    }

    return Math.max(helper(nums.slice(0, nums.length - 1)), helper(nums.slice(1)));
};