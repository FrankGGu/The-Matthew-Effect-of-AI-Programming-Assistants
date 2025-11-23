function combinationSum(candidates, target) {
    const result = [];

    function backtrack(start, path, remaining) {
        if (remaining === 0) {
            result.push([...path]);
            return;
        }
        for (let i = start; i < candidates.length; i++) {
            if (candidates[i] > remaining) continue;
            path.push(candidates[i]);
            backtrack(i, path, remaining - candidates[i]);
            path.pop();
        }
    }

    backtrack(0, [], target);
    return result;
}