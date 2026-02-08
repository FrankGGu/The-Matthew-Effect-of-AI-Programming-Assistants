var beautifulSubsets = function(nums, k) {
    let count = 0;
    const n = nums.length;

    function backtrack(index, subset) {
        if (index === n) {
            if (subset.length > 0) {
                count++;
            }
            return;
        }

        // Option 1: Exclude nums[index]
        backtrack(index + 1, subset);

        // Option 2: Include nums[index] if it's valid
        let isValid = true;
        for (let num of subset) {
            if (Math.abs(num - nums[index]) === k) {
                isValid = false;
                break;
            }
        }

        if (isValid) {
            backtrack(index + 1, [...subset, nums[index]]);
        }
    }

    backtrack(0, []);
    return count;
};