var minDays = function(n) {
    const memo = new Map();

    function dp(currentN) {
        if (currentN <= 1) {
            return currentN;
        }
        if (memo.has(currentN)) {
            return memo.get(currentN);
        }

        // Option 1: Reduce currentN to a multiple of 2 by eating (currentN % 2) oranges,
        // then eat half of the remaining oranges.
        // This costs (currentN % 2) days for eating 1 orange, plus 1 day for the /2 operation.
        // Then recursively solve for currentN / 2.
        let costOption1 = (currentN % 2) + 1 + dp(Math.floor(currentN / 2));

        // Option 2: Reduce currentN to a multiple of 3 by eating (currentN % 3) oranges,
        // then eat two-thirds of the remaining oranges.
        // This costs (currentN % 3) days for eating 1 orange, plus 1 day for the /3 operation.
        // Then recursively solve for currentN / 3.
        let costOption2 = (currentN % 3) + 1 + dp(Math.floor(currentN / 3));

        const result = Math.min(costOption1, costOption2);
        memo.set(currentN, result);
        return result;
    }

    return dp(n);
};