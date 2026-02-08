var findDiagonalOrder = function(nums) {
    let result = [];
    let map = new Map();

    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < nums[i].length; j++) {
            if (!map.has(i + j)) {
                map.set(i + j, []);
            }
            map.get(i + j).push(nums[i][j]);
        }
    }

    for (let k = 0; k < map.size; k++) {
        if (k % 2 === 0) {
            result.push(...map.get(k).reverse());
        } else {
            result.push(...map.get(k));
        }
    }

    return result;
};