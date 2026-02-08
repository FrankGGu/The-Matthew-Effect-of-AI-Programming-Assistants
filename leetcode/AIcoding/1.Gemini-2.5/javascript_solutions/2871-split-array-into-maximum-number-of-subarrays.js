var maxSubarrays = function(nums) {
    const n = nums.length;

    let totalAND = -1;
    let hasZero = false;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            hasZero = true;
            break;
        }
        if (totalAND === -1) {
            totalAND = nums[i];
        } else {
            totalAND &= nums[i];
        }
    }

    if (hasZero) {
        return 0;
    }

    if (totalAND > 0) {
        return n;
    } else {
        let count = 0;
        let currentSubarrayAND = -1;

        for (let i = 0; i < n; i++) {
            if (currentSubarrayAND === -1) {
                currentSubarrayAND = nums[i];
            } else {
                currentSubarrayAND &= nums[i];
            }

            if (currentSubarrayAND > 0) {
                count++;
                currentSubarrayAND = -1;
            }
        }
        return count;
    }
};