var waysToMakeFair = function(nums) {
    let evenSum = 0;
    let oddSum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            evenSum += nums[i];
        } else {
            oddSum += nums[i];
        }
    }

    let count = 0;
    let currentEvenSum = 0;
    let currentOddSum = 0;

    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            evenSum -= nums[i];
        } else {
            oddSum -= nums[i];
        }

        if (currentEvenSum + oddSum === currentOddSum + evenSum) {
            count++;
        }

        if (i % 2 === 0) {
            currentEvenSum += nums[i];
        } else {
            currentOddSum += nums[i];
        }
    }

    return count;
};