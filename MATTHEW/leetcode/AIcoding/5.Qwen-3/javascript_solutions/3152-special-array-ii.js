function findSpecialInteger(nums, queries) {
    const n = nums.length;
    const map = new Map();

    for (const num of nums) {
        map.set(num, (map.get(num) || 0) + 1);
    }

    const result = [];

    for (const q of queries) {
        const count = map.get(nums[q]) || 0;
        result.push(count > n / 2);
    }

    return result;
}