var getLongestSubsequence = function(nums, groups) {
    let result = [];
    let groupIndex = 0;

    for (let i = 0; i < nums.length; i++) {
        if (groupIndex < groups.length && canAppend(nums, i, groups[groupIndex])) {
            result.push(...groups[groupIndex]);
            i += groups[groupIndex].length - 1;
            groupIndex++;
        }
    }

    return result;

    function canAppend(nums, index, group) {
        if (index + group.length > nums.length) {
            return false;
        }

        for (let i = 0; i < group.length; i++) {
            if (nums[index + i] !== group[i]) {
                return false;
            }
        }

        return true;
    }
};