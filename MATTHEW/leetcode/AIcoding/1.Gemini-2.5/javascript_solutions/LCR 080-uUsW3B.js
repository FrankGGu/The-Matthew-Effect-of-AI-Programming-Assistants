var combine = function(n, k) {
    const result = [];
    const currentCombination = [];

    function backtrack(startNum) {
        if (currentCombination.length === k) {
            result.push([...currentCombination]);
            return;
        }

        // Optimization: The loop for 'i' should not go beyond
        // n - (k - currentCombination.length) + 1.
        // This ensures there are enough remaining numbers to complete the combination.
        const upperLimit = n - (k - currentCombination.length) + 1;
        for (let i = startNum; i <= upperLimit; i++) {
            currentCombination.push(i);
            backtrack(i + 1);
            currentCombination.pop();
        }
    }

    backtrack(1);
    return result;
};