var findSubsequences = function(nums) {
    const result = new Set();
    const current = [];

    function dfs(startIndex) {
        if (current.length >= 2) {
            result.add(JSON.stringify([...current]));
        }

        const usedInLevel = new Set();

        for (let i = startIndex; i < nums.length; i++) {
            if (usedInLevel.has(nums[i])) {
                continue;
            }

            if (current.length === 0 || nums[i] >= current[current.length - 1]) {
                usedInLevel.add(nums[i]);

                current.push(nums[i]);
                dfs(i + 1);
                current.pop();
            }
        }
    }

    dfs(0);

    return Array.from(result).map(str => JSON.parse(str));
};