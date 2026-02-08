var combinationSum = function(candidates, target) {
    const result = [];

    function backtrack(currentCombination, remainingTarget, startIndex) {
        if (remainingTarget === 0) {
            result.push([...currentCombination]);
            return;
        }

        if (remainingTarget < 0) {
            return;
        }

        for (let i = startIndex; i < candidates.length; i++) {
            currentCombination.push(candidates[i]);
            backtrack(currentCombination, remainingTarget - candidates[i], i);
            currentCombination.pop();
        }
    }

    backtrack([], target, 0);
    return result;
};