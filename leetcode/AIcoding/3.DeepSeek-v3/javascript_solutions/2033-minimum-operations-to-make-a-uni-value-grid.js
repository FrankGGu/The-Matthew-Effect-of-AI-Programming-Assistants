var minOperations = function(grid, x) {
    const m = grid.length;
    const n = grid[0].length;
    const nums = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            nums.push(grid[i][j]);
        }
    }

    nums.sort((a, b) => a - b);
    const median = nums[Math.floor(nums.length / 2)];
    let operations = 0;

    for (const num of nums) {
        const diff = Math.abs(num - median);
        if (diff % x !== 0) {
            return -1;
        }
        operations += diff / x;
    }

    return operations;
};