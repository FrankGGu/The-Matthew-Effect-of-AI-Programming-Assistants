var findDiagonalOrder = function(nums) {
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < nums[i].length; j++) {
            const sum = i + j;
            if (!map.has(sum)) {
                map.set(sum, []);
            }
            map.get(sum).push(nums[i][j]);
        }
    }

    const result = [];
    let index = 0;
    while (map.has(index)) {
        const arr = map.get(index);
        for (let i = arr.length - 1; i >= 0; i--) {
            result.push(arr[i]);
        }
        index++;
    }

    return result;
};