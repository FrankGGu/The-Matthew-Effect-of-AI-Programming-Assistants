var getLongestUnequalAdjacentGroupsSubsequence = function(groups, nums) {
    const result = [];

    for (let i = 0; i < groups.length; i++) {
        if (result.length === 0) {
            result.push(i);
        } else {
            const lastIndex = result[result.length - 1];
            if (groups[i] !== groups[lastIndex]) {
                result.push(i);
            } else {
                if (nums[i] < nums[lastIndex]) {
                    result[result.length - 1] = i;
                }
            }
        }
    }

    return result;
};