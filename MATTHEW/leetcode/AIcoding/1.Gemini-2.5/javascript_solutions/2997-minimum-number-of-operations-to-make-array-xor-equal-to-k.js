var minOperations = function(nums, k) {
    let currentXorSum = 0;
    for (let i = 0; i < nums.length; i++) {
        currentXorSum ^= nums[i];
    }

    let diff = currentXorSum ^ k;
    let operations = 0;

    while (diff > 0) {
        operations++;
        diff &= (diff - 1);
    }

    return operations;
};