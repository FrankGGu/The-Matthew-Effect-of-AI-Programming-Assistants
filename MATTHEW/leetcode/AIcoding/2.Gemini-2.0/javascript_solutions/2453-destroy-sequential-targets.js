var destroyTargets = function(nums, space) {
    let map = new Map();
    let maxCount = 0;
    let ans = Infinity;

    for (let num of nums) {
        let mod = num % space;
        if (!map.has(mod)) {
            map.set(mod, 0);
        }
        map.set(mod, map.get(mod) + 1);
        maxCount = Math.max(maxCount, map.get(mod));
    }

    for (let num of nums) {
        let mod = num % space;
        if (map.get(mod) === maxCount) {
            ans = Math.min(ans, num);
        }
    }

    return ans;
};