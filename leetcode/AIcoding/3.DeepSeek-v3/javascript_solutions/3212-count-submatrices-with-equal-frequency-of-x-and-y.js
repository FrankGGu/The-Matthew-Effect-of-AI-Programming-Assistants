var countSubmatricesWithEqualFrequency = function(nums, x, y) {
    let count = 0;
    const m = nums.length;
    const n = nums[0].length;
    const prefix = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0).map(() => ({ x: 0, y: 0 })));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefix[i][j].x = prefix[i-1][j].x + prefix[i][j-1].x - prefix[i-1][j-1].x + (nums[i-1][j-1] === x ? 1 : 0);
            prefix[i][j].y = prefix[i-1][j].y + prefix[i][j-1].y - prefix[i-1][j-1].y + (nums[i-1][j-1] === y ? 1 : 0);
        }
    }

    for (let i1 = 1; i1 <= m; i1++) {
        for (let j1 = 1; j1 <= n; j1++) {
            for (let i2 = i1; i2 <= m; i2++) {
                for (let j2 = j1; j2 <= n; j2++) {
                    const xCount = prefix[i2][j2].x - prefix[i1-1][j2].x - prefix[i2][j1-1].x + prefix[i1-1][j1-1].x;
                    const yCount = prefix[i2][j2].y - prefix[i1-1][j2].y - prefix[i2][j1-1].y + prefix[i1-1][j1-1].y;
                    if (xCount === yCount && xCount > 0) {
                        count++;
                    }
                }
            }
        }
    }

    return count;
};