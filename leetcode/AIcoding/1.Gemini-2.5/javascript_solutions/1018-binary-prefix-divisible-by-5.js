var prefixesDivBy5 = function(nums) {
    const result = [];
    let currentRemainder = 0;

    for (let i = 0; i < nums.length; i++) {
        currentRemainder = (currentRemainder * 2 + nums[i]) % 5;
        result.push(currentRemainder === 0);
    }

    return result;
};