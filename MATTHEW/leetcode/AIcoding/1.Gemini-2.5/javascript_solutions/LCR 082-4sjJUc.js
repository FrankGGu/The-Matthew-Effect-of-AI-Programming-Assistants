var combinationSum2 = function(candidates, target) {
    const result = [];
    candidates.sort((a, b) => a - b);

    function backtrack(start, currentSum, currentCombination) {
        if (currentSum === target) {
            result.push([...currentCombination]);
            return;
        }
        if (currentSum > target) {
            return;
        }

        for (let i = start; i < candidates.length; i++) {
            if (i > start && candidates[i] === candidates[i - 1]) {
                continue;
            }

            currentCombination.push(candidates[i]);
            backtrack(i + 1, currentSum + candidates[i], currentCombination);
            currentCombination.pop();
        }
    }

    backtrack(0, 0, []);
    return result;
};