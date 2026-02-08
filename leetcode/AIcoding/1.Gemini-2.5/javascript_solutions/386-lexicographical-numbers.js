var lexicalOrder = function(n) {
    const result = [];

    function dfs(currentNum) {
        // Add the current number to the result list
        result.push(currentNum);

        // Try to append digits 0-9 to form the next lexicographically ordered numbers
        for (let i = 0; i <= 9; i++) {
            const nextNum = currentNum * 10 + i;

            // If the next number exceeds n, then any further numbers formed by appending larger digits
            // or more digits will also exceed n. So, we can stop exploring this branch.
            if (nextNum > n) {
                break;
            }

            // Recursively call dfs for the next number
            dfs(nextNum);
        }
    }

    // Start the DFS from single-digit numbers 1 through 9.
    // Each of these numbers forms the root of a lexicographical branch.
    for (let i = 1; i <= 9; i++) {
        if (i <= n) { // Only start a DFS branch if the root number itself is within the range [1, n]
            dfs(i);
        }
    }

    return result;
};