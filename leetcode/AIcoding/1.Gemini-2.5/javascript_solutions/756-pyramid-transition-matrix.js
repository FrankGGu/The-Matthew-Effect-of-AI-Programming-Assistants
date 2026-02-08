var pyramidTransition = function(bottom, allowed) {
    const memoAllowed = new Map();
    for (const s of allowed) {
        const prefix = s.substring(0, 2);
        const top = s.substring(2);
        if (!memoAllowed.has(prefix)) {
            memoAllowed.set(prefix, new Set());
        }
        memoAllowed.get(prefix).add(top);
    }

    const memo = new Map(); // Memoization for dfs(currentLevel)

    function dfs(currentLevel) {
        if (currentLevel.length === 1) {
            return true;
        }
        if (memo.has(currentLevel)) {
            return memo.get(currentLevel);
        }

        const nextLevelBlocks = []; // To build the next level block by block

        // This inner recursive function tries to build one possible next level
        // and then recursively calls dfs on it.
        function generateAndRecurse(index) {
            // If we have determined all blocks for the next level
            if (index === currentLevel.length - 1) {
                const nextLevelStr = nextLevelBlocks.join('');
                if (dfs(nextLevelStr)) {
                    return true;
                }
                return false;
            }

            const prefix = currentLevel[index] + currentLevel[index + 1];
            if (!memoAllowed.has(prefix)) {
                return false; // No allowed top block for this pair
            }

            for (const top of memoAllowed.get(prefix)) {
                nextLevelBlocks.push(top);
                if (generateAndRecurse(index + 1)) {
                    return true;
                }
                nextLevelBlocks.pop(); // Backtrack
            }

            return false; // No top block for current prefix led to a solution
        }

        const result = generateAndRecurse(0);
        memo.set(currentLevel, result);
        return result;
    }

    return dfs(bottom);
};