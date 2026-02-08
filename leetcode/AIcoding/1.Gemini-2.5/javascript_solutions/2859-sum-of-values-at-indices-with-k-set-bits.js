var sumIndicesWithKSetBits = function(nums, k) {
    let totalSum = 0;

    for (let i = 0; i < nums.length; i++) {
        let num = i;
        let setBitsCount = 0;
        while (num > 0) {
            num &= (num - 1);
            setBitsCount++;
        }

        if (setBitsCount === k) {
            totalSum += nums[i];
        }
    }

    return totalSum;
};