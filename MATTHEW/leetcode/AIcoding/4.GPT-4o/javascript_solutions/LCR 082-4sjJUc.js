var combinationSum2 = function(candidates, target) {
    const result = [];
    candidates.sort((a, b) => a - b);

    const backtrack = (start, path, target) => {
        if (target === 0) {
            result.push([...path]);
            return;
        }
        for (let i = start; i < candidates.length; i++) {
            if (i > start && candidates[i] === candidates[i - 1]) continue;
            if (candidates[i] > target) break;
            path.push(candidates[i]);
            backtrack(i + 1, path, target - candidates[i]);
            path.pop();
        }
    };

    backtrack(0, [], target);
    return result;
};