var findMaxLength = function(nums) {
    let sum = 0;
    let maxLength = 0;
    const sumMap = new Map();

    // Initialize the map with sum 0 at index -1 to handle subarrays starting from index 0
    sumMap.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            sum -= 1;
        } else {
            sum += 1;
        }

        if (sumMap.has(sum)) {
            maxLength = Math.max(maxLength, i - sumMap.get(sum));
        } else {
            sumMap.set(sum, i);
        }
    }

    return maxLength;
};