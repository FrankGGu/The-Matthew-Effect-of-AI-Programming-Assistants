var findDiagonalOrder = function(nums) {
    const diagonalGroups = [];

    for (let r = 0; r < nums.length; r++) {
        for (let c = 0; c < nums[r].length; c++) {
            const sum = r + c;
            if (!diagonalGroups[sum]) {
                diagonalGroups[sum] = [];
            }
            diagonalGroups[sum].push(nums[r][c]);
        }
    }

    const result = [];
    for (let i = 0; i < diagonalGroups.length; i++) {
        if (diagonalGroups[i]) {
            result.push(...diagonalGroups[i].reverse());
        }
    }

    return result;
};