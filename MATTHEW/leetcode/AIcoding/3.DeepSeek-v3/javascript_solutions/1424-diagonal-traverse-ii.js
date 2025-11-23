var findDiagonalOrder = function(nums) {
    const groups = new Map();
    for (let row = 0; row < nums.length; row++) {
        for (let col = 0; col < nums[row].length; col++) {
            const diagonal = row + col;
            if (!groups.has(diagonal)) {
                groups.set(diagonal, []);
            }
            groups.get(diagonal).unshift(nums[row][col]);
        }
    }

    const result = [];
    const sortedKeys = [...groups.keys()].sort((a, b) => a - b);
    for (const key of sortedKeys) {
        result.push(...groups.get(key));
    }
    return result;
};