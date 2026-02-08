var subsets = function(nums) {
    const result = [];
    const currentSubset = [];

    function backtrack(start) {
        result.push([...currentSubset]);

        for (let i = start; i < nums.length; i++) {
            currentSubset.push(nums[i]);
            backtrack(i + 1);
            currentSubset.pop();
        }
    }

    backtrack(0);
    return result;
};