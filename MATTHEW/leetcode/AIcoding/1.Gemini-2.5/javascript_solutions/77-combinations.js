var combine = function(n, k) {
    const result = [];
    const currentCombination = [];

    function backtrack(start) {
        if (currentCombination.length === k) {
            result.push([...currentCombination]);
            return;
        }

        for (let i = start; i <= n - (k - currentCombination.length) + 1; i++) {
            currentCombination.push(i);
            backtrack(i + 1);
            currentCombination.pop();
        }
    }

    backtrack(1);
    return result;
};