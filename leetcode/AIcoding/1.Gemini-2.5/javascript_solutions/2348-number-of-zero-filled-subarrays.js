var zeroFilledSubarrays = function(nums) {
    let totalSubarrays = 0;
    let currentZeroStreak = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            currentZeroStreak++;
            totalSubarrays += currentZeroStreak;
        } else {
            currentZeroStreak = 0;
        }
    }

    return totalSubarrays;
};