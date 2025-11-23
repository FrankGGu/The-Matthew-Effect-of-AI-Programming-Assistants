var maxOperations = function(nums) {
    if (nums.length < 2) {
        return 0;
    }

    const targetScore = nums[0] + nums[1];
    let operations = 1;

    for (let i = 2; i < nums.length - 1; i += 2) {
        if (nums[i] + nums[i+1] === targetScore) {
            operations++;
        } else {
            break;
        }
    }

    return operations;
};