var arrayChange = function(nums, queries) {
    const n = nums.length;
    const result = new Array(queries.length).fill(0);
    const map = new Map();

    for (let i = 0; i < n; i++) {
        map.set(nums[i], (map.get(nums[i]) || 0) + 1);
    }

    for (let i = 0; i < queries.length; i++) {
        const [oldVal, newVal] = queries[i];
        if (!map.has(oldVal) || (oldVal === newVal)) {
            result[i] = nums.length;
            continue;
        }

        const count = map.get(oldVal);
        if (map.has(newVal)) {
            result[i] = nums.length - count;
        } else {
            result[i] = nums.length - count + 1;
        }
    }

    return result;
};