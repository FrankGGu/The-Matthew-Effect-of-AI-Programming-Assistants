var reductionOperations = function(nums) {
    nums.sort((a, b) => a - b);
    let res = 0;
    let up = 0;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] != nums[i - 1]) {
            up++;
        }
        res += up;
    }

    return res;
};