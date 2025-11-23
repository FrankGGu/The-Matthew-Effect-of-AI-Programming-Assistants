var subsets = function(nums) {
    let result = [];
    backtrack(0, []);
    return result;

    function backtrack(start, current) {
        result.push([...current]);
        for (let i = start; i < nums.length; i++) {
            current.push(nums[i]);
            backtrack(i + 1, current);
            current.pop();
        }
    }
};