var findTheLargestOutlier = function(nums) {
    let evenCount = 0;
    let oddCount = 0;
    let firstEven = null;
    let firstOdd = null;

    for (let i = 0; i < Math.min(nums.length, 3); i++) {
        if (nums[i] % 2 === 0) {
            evenCount++;
            if (firstEven === null) {
                firstEven = nums[i];
            }
        } else {
            oddCount++;
            if (firstOdd === null) {
                firstOdd = nums[i];
            }
        }
    }

    let targetParityIsEven = false; // True if the outlier is even, False if the outlier is odd

    if (evenCount === 1) { // Majority is odd, so the single even number is the outlier
        targetParityIsEven = true;
    } else { // Majority is even (or it's the first three are all same parity, which means the outlier is the other parity)
        // If oddCount === 1, then majority is even, so the single odd number is the outlier.
        // If evenCount === 2 and oddCount === 1, then majority is even, so the single odd number is the outlier.
        // If evenCount === 3, then majority is even, so the outlier must be odd.
        // In all cases where evenCount is not 1, we are looking for an odd outlier.
        targetParityIsEven = false;
    }

    // A simpler way to determine targetParityIsEven:
    // If the count of even numbers among the first three is less than the count of odd numbers,
    // it means the majority is odd, so we are looking for the even outlier.
    // Otherwise, the majority is even, so we are looking for the odd outlier.
    targetParityIsEven = (evenCount < oddCount);

    for (const num of nums) {
        if ((num % 2 === 0) === targetParityIsEven) {
            return num;
        }
    }

    // This line should ideally not be reached if the problem guarantees an outlier.
    return -1; 
};