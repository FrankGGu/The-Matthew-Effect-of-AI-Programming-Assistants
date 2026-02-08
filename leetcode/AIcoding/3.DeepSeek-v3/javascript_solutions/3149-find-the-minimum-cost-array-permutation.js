var findPermutation = function(nums) {
    const n = nums.length;
    let minCost = Infinity;
    let bestPerm = [];

    function backtrack(path, used, cost) {
        if (path.length === n) {
            const totalCost = cost + Math.abs(path[path.length - 1] - nums[path[0]]);
            if (totalCost < minCost) {
                minCost = totalCost;
                bestPerm = [...path];
            }
            return;
        }

        for (let i = 0; i < n; i++) {
            if (!used[i]) {
                used[i] = true;
                path.push(i);
                const newCost = path.length === 1 ? 0 : cost + Math.abs(path[path.length - 2] - nums[path[path.length - 1]]);
                backtrack(path, used, newCost);
                path.pop();
                used[i] = false;
            }
        }
    }

    backtrack([], new Array(n).fill(false), 0);
    return bestPerm;
};