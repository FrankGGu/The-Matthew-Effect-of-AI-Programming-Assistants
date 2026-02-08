var combinationSum3 = function(k, n) {
    const result = [];

    function backtrack(combination, remaining, start) {
        if (combination.length === k) {
            if (remaining === 0) {
                result.push([...combination]);
            }
            return;
        }

        for (let i = start; i <= 9; i++) {
            combination.push(i);
            backtrack(combination, remaining - i, i + 1);
            combination.pop();
        }
    }

    backtrack([], n, 1);
    return result;
};