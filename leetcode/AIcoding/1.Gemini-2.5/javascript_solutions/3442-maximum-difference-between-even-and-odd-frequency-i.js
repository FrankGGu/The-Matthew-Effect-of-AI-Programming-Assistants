var maxDifference = function(nums) {
    let evenCount = 0;
    let oddCount = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 === 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }

    return Math.abs(evenCount - oddCount);
};