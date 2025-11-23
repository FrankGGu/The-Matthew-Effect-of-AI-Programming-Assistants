var waysToSplitArray = function(nums) {
    let first = -1;
    let last = -1;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            if (first === -1) {
                first = i;
            }
            last = i;
        }
    }

    if (first === -1) {
        return 0;
    }

    let count = 1;
    let ans = 1;
    for (let i = first + 1; i <= last; i++) {
        if (nums[i] === 1) {
            ans = (ans * count) % (10**9 + 7);
            count = 1;
        } else {
            count++;
        }
    }

    return ans;
};