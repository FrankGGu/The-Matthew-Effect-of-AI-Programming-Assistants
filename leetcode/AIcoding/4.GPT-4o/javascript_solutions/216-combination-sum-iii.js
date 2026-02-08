var combinationSum3 = function(k, n) {
    const result = [];

    const backtrack = (start, path, sum) => {
        if (path.length === k && sum === n) {
            result.push([...path]);
            return;
        }
        for (let i = start; i <= 9; i++) {
            if (path.length < k && sum + i <= n) {
                path.push(i);
                backtrack(i + 1, path, sum + i);
                path.pop();
            }
        }
    };

    backtrack(1, [], 0);
    return result;
};