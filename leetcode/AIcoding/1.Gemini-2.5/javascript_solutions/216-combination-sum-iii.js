var combinationSum3 = function(k, n) {
    const result = [];
    const currentCombination = [];

    function backtrack(startNum, count, currentSum) {
        if (count === k) {
            if (currentSum === n) {
                result.push([...currentCombination]);
            }
            return;
        }

        if (currentSum > n) {
            return;
        }

        for (let i = startNum; i <= 9; i++) {
            currentCombination.push(i);
            backtrack(i + 1, count + 1, currentSum + i);
            currentCombination.pop();
        }
    }

    backtrack(1, 0, 0);
    return result;
};