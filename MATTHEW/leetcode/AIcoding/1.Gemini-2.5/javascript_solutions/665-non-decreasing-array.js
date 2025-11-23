var checkPossibility = function(nums) {
    let violations = 0;
    let violationIndex = -1;

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            violations++;
            violationIndex = i;
        }
    }

    if (violations === 0) {
        return true;
    }
    if (violations > 1) {
        return false;
    }

    // Only one violation found at index 'violationIndex'
    const i = violationIndex;

    // Option 1: Try to fix by modifying nums[i]
    // This means we would effectively change nums[i] to nums[i+1]
    // This is valid if nums[i-1] <= nums[i+1] (if i > 0)
    // If i == 0, there is no nums[i-1], so it's always valid to change nums[0].
    let canFixByModifyingI = false;
    if (i === 0 || nums[i - 1] <= nums[i + 1]) {
        canFixByModifyingI = true;
    }

    // Option 2: Try to fix by modifying nums[i+1]
    // This means we would effectively change nums[i+1] to nums[i]
    // This is valid if nums[i] <= nums[i+2] (if i+2 < nums.length)
    // If i+1 is the last element (i+2 >= nums.length), there is no nums[i+2], so it's always valid to change nums[i+1].
    let canFixByModifyingIPlus1 = false;
    if (i + 2 >= nums.length || nums[i] <= nums[i + 2]) {
        canFixByModifyingIPlus1 = true;
    }

    return canFixByModifyingI || canFixByModifyingIPlus1;
};