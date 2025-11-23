var combinationSum = function(candidates, target) {
    const result = [];
    const currentCombination = [];

    function backtrack(remaining, startIndex) {
        if (remaining < 0) {
            return;
        }
        if (remaining === 0) {
            result.push([...currentCombination]);
            return;
        }

        for (let i = startIndex; i < candidates.length; i++) {
            currentCombination.push(candidates[i]);
            backtrack(remaining - candidates[i], i);
            currentCombination.pop();
        }
    }

    backtrack(target, 0);
    return result;
};