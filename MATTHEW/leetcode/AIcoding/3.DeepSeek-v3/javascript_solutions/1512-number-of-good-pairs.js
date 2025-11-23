var numIdenticalPairs = function(nums) {
    let count = 0;
    const map = {};
    for (const num of nums) {
        if (map[num]) {
            count += map[num];
            map[num]++;
        } else {
            map[num] = 1;
        }
    }
    return count;
};