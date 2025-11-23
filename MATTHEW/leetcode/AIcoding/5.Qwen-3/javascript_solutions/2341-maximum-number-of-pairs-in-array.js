var maximumNumberOfPairs = function(nums) {
    let count = 0;
    let map = new Map();

    for (let num of nums) {
        if (map.has(num)) {
            count++;
            map.set(num, map.get(num) - 1);
            if (map.get(num) === 0) {
                map.delete(num);
            }
        } else {
            map.set(num, 1);
        }
    }

    return count;
};