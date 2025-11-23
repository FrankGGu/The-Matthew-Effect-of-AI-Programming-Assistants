var combinationSum2 = function(candidates, target) {
    candidates.sort((a, b) => a - b);
    const result = [];

    function backtrack(combination, remaining, start) {
        if (remaining === 0) {
            result.push([...combination]);
            return;
        }

        if (remaining < 0) {
            return;
        }

        for (let i = start; i < candidates.length; i++) {
            if (i > start && candidates[i] === candidates[i - 1]) {
                continue;
            }

            combination.push(candidates[i]);
            backtrack(combination, remaining - candidates[i], i + 1);
            combination.pop();
        }
    }

    backtrack([], target, 0);
    return result;
};