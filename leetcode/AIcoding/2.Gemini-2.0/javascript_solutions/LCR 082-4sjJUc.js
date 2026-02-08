var combinationSum2 = function(candidates, target) {
    candidates.sort((a, b) => a - b);
    const result = [];
    const combination = [];

    function backtrack(start, remaining) {
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
            backtrack(i + 1, remaining - candidates[i]);
            combination.pop();
        }
    }

    backtrack(0, target);
    return result;
};