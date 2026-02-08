var combinationSum = function(candidates, target) {
    const result = [];

    function backtrack(start, current, sum) {
        if (sum === target) {
            result.push([...current]);
            return;
        }
        if (sum > target) {
            return;
        }
        for (let i = start; i < candidates.length; i++) {
            current.push(candidates[i]);
            backtrack(i, current, sum + candidates[i]);
            current.pop();
        }
    }

    backtrack(0, [], 0);
    return result;
};