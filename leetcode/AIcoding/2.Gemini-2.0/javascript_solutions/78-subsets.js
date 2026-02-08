var subsets = function(nums) {
    const result = [];

    function backtrack(index, currentSubset) {
        result.push([...currentSubset]);

        for (let i = index; i < nums.length; i++) {
            currentSubset.push(nums[i]);
            backtrack(i + 1, currentSubset);
            currentSubset.pop();
        }
    }

    backtrack(0, []);
    return result;
};