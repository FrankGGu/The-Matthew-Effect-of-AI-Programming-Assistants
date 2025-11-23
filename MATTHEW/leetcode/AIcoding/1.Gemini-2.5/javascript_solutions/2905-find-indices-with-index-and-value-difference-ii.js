var findIndices = function(nums, indexDifference, valueDifference) {
    let n = nums.length;

    // minIdx stores the index of the minimum value encountered so far
    // maxIdx stores the index of the maximum value encountered so far
    // These indices refer to elements in the range [0, j - indexDifference]
    let minIdx = 0;
    let maxIdx = 0;

    // Iterate 'j' from indexDifference up to n-1
    // For each 'j', we consider 'i' such that i <= j - indexDifference
    for (let j = indexDifference; j < n; j++) {
        // The index 'j - indexDifference' is the newest candidate for 'i'
        // that satisfies the index difference condition with 'j'.
        let candidate_i_for_update = j - indexDifference;

        // Update minIdx and maxIdx by considering nums[candidate_i_for_update].
        // minIdx will hold the index of the minimum value in nums[0...candidate_i_for_update].
        // maxIdx will hold the index of the maximum value in nums[0...candidate_i_for_update].
        if (nums[candidate_i_for_update] < nums[minIdx]) {
            minIdx = candidate_i_for_update;
        }
        if (nums[candidate_i_for_update] > nums[maxIdx]) {
            maxIdx = candidate_i_for_update;
        }

        // Now, check if the current 'j' forms a valid pair with either minIdx or maxIdx.
        // The indices minIdx and maxIdx are guaranteed to satisfy:
        // 1. minIdx <= j - indexDifference (and similarly for maxIdx)
        //    This implies j - minIdx >= indexDifference, so abs(j - minIdx) >= indexDifference.
        // 2. We must also ensure that minIdx (or maxIdx) is distinct from j.
        //    If indexDifference > 0, then j - indexDifference < j, so minIdx < j is guaranteed.
        //    If indexDifference = 0, then minIdx could be equal to j.
        //    We explicitly check minIdx !== j to satisfy the distinctness requirement.

        if (minIdx !== j && Math.abs(nums[j] - nums[minIdx]) >= valueDifference) {
            return [minIdx, j];
        }
        if (maxIdx !== j && Math.abs(nums[j] - nums[maxIdx]) >= valueDifference) {
            return [maxIdx, j];
        }
    }

    // If no such pair is found after checking all possible 'j', return [-1, -1].
    return [-1, -1];
};