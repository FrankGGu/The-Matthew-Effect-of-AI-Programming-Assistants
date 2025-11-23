var movesToMakeZigzag = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    // Function to calculate cost for a given zigzag pattern
    // `isEvenIndexGreater` determines the pattern:
    // true: nums[0] > nums[1] < nums[2] > nums[3] ... (even indices are greater than next)
    // false: nums[0] < nums[1] > nums[2] < nums[3] ... (even indices are less than next)
    function calculateCost(arr, isEvenIndexGreater) {
        let cost = 0;
        let tempArr = [...arr]; // Create a mutable copy to track changes

        for (let i = 0; i < n - 1; i++) {
            if ((i % 2 === 0 && isEvenIndexGreater) || (i % 2 !== 0 && !isEvenIndexGreater)) {
                // Current requirement: tempArr[i] > tempArr[i+1]
                if (tempArr[i] <= tempArr[i+1]) {
                    let diff = tempArr[i+1] - tempArr[i] + 1;
                    cost += diff;
                    tempArr[i+1] -= diff; // Decrease tempArr[i+1] to satisfy condition
                }
            } else {
                // Current requirement: tempArr[i] < tempArr[i+1]
                if (tempArr[i] >= tempArr[i+1]) {
                    let diff = tempArr[i] - tempArr[i+1] + 1;
                    cost += diff;
                    tempArr[i] -= diff; // Decrease tempArr[i] to satisfy condition
                }
            }
        }
        return cost;
    }

    // Calculate cost for the first pattern: nums[0] > nums[1] < nums[2] > nums[3] ...
    // This means for even i, nums[i] > nums[i+1]
    let cost1 = calculateCost(nums, true);

    // Calculate cost for the second pattern: nums[0] < nums[1] > nums[2] < nums[3] ...
    // This means for even i, nums[i] < nums[i+1]
    let cost2 = calculateCost(nums, false);

    return Math.min(cost1, cost2);
};