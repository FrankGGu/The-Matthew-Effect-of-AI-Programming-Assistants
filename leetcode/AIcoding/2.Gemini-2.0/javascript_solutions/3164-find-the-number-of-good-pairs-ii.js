var countGoodPairs = function(nums, k) {
    let count = 0;
    let map = new Map();

    for (let num of nums) {
        if (map.has(num)) {
            count += map.get(num);
            map.set(num, map.get(num) + 1);
        } else {
            map.set(num, 1);
        }
    }

    let goodPairs = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (Math.abs(nums[i] - nums[j]) <= k) {
                goodPairs++;
            }
        }
    }

    let result = 0;
    map = new Map();
    for (let num of nums) {
        let target = 0;
        if (map.has(num)) {
            target = map.get(num);
        }

        for (let key of map.keys()) {
            if (Math.abs(num - key) <= k) {

            }
        }

        map.set(num, target + 1);
    }

    count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (Math.abs(nums[i] - nums[j]) <= k) {
                count++;
            }
        }
    }

    return count;
};