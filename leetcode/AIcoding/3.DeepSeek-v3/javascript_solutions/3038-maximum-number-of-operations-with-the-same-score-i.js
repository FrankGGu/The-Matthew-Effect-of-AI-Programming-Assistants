var maxOperations = function(nums) {
    if (nums.length < 2) return 0;
    const initialSum = nums[0] + nums[1];
    let count = 0;
    let i = 0;
    while (i + 1 < nums.length) {
        const currentSum = nums[i] + nums[i + 1];
        if (currentSum === initialSum) {
            count++;
            i += 2;
        } else {
            break;
        }
    }
    return count;
};