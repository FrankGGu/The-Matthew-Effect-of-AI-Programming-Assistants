var countMaxOrSubsets = function(nums) {
    let maxOr = 0;
    let count = 0;

    const backtrack = (index, currentOr) => {
        if (index === nums.length) {
            if (currentOr > maxOr) {
                maxOr = currentOr;
                count = 1;
            } else if (currentOr === maxOr) {
                count++;
            }
            return;
        }
        backtrack(index + 1, currentOr | nums[index]);
        backtrack(index + 1, currentOr);
    };

    backtrack(0, 0);
    return count;
};