var rob = function(nums) {
    if (nums.length === 0) {
        return 0;
    }
    if (nums.length === 1) {
        return nums[0];
    }

    const robLinear = (arr) => {
        if (arr.length === 0) {
            return 0;
        }
        if (arr.length === 1) {
            return arr[0];
        }

        let prev2 = 0;
        let prev1 = 0;

        for (let i = 0; i < arr.length; i++) {
            let current = Math.max(prev1, prev2 + arr[i]);
            prev2 = prev1;
            prev1 = current;
        }
        return prev1;
    };

    const max1 = robLinear(nums.slice(0, nums.length - 1));
    const max2 = robLinear(nums.slice(1, nums.length));

    return Math.max(max1, max2);
};