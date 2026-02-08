var destroyTargets = function(nums, space) {
    const map = new Map();
    for (const num of nums) {
        const mod = num % space;
        if (!map.has(mod)) {
            map.set(mod, []);
        }
        map.get(mod).push(num);
    }

    let maxSize = 0;
    let result = Infinity;
    for (const [mod, arr] of map) {
        if (arr.length > maxSize) {
            maxSize = arr.length;
            result = Math.min(...arr);
        } else if (arr.length === maxSize) {
            const currentMin = Math.min(...arr);
            if (currentMin < result) {
                result = currentMin;
            }
        }
    }
    return result;
};