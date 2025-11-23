var findClosestNumber = function(nums) {
    let closestNum = nums[0];
    let minAbsDiff = Math.abs(nums[0]);

    for (let i = 1; i < nums.length; i++) {
        const currentNum = nums[i];
        const currentAbsDiff = Math.abs(currentNum);

        if (currentAbsDiff < minAbsDiff) {
            minAbsDiff = currentAbsDiff;
            closestNum = currentNum;
        } else if (currentAbsDiff === minAbsDiff) {
            // If absolute differences are equal, choose the larger number
            if (currentNum > closestNum) {
                closestNum = currentNum;
            }
        }
    }

    return closestNum;
};