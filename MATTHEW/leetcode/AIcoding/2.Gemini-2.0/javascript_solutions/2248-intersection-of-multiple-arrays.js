var intersection = function(nums) {
    if (!nums || nums.length === 0) return [];

    let map = new Map();
    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < nums[i].length; j++) {
            let num = nums[i][j];
            map.set(num, (map.get(num) || 0) + 1);
        }
    }

    let result = [];
    for (let [num, count] of map) {
        if (count === nums.length) {
            result.push(num);
        }
    }

    return result.sort((a, b) => a - b);
};