var combinationSum = function(candidates, target) {
    let result = [];
    let path = [];

    function backtrack(start, target) {
        if (target === 0) {
            result.push([...path]);
            return;
        }
        for (let i = start; i < candidates.length; i++) {
            if (candidates[i] > target) continue;
            path.push(candidates[i]);
            backtrack(i, target - candidates[i]);
            path.pop();
        }
    }

    backtrack(0, target);
    return result;
};