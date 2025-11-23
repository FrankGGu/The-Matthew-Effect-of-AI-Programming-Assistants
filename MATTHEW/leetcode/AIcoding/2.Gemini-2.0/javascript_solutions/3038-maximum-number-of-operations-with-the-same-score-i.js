var maxOperations = function(nums) {
    if (nums.length < 2) {
        return 0;
    }

    let score = nums[0] + nums[1];
    let count = 1;
    let i = 2;

    while (i < nums.length) {
        if (nums[i] + nums[i + 1] === score) {
            count++;
            i += 2;
        } else {
            break;
        }
    }

    return count;
};