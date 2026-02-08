var countMatchingSubarrays = function(nums, pattern) {
    const n = nums.length;
    const m = pattern.length;
    let count = 0;

    for (let i = 0; i <= n - (m + 1); i++) {
        let currentSubarrayMatches = true;
        for (let k = 0; k < m; k++) {
            let actualRelation;
            if (nums[i + k + 1] > nums[i + k]) {
                actualRelation = 1;
            } else if (nums[i + k + 1] < nums[i + k]) {
                actualRelation = -1;
            } else {
                actualRelation = 0;
            }

            if (actualRelation !== pattern[k]) {
                currentSubarrayMatches = false;
                break;
            }
        }

        if (currentSubarrayMatches) {
            count++;
        }
    }

    return count;
};