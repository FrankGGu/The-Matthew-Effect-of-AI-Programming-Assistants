function findSmallestInteger(nums, value) {
    const n = nums.length;
    const map = new Map();
    let sum = 0;

    for (let i = 0; i < n; i++) {
        sum += nums[i];
        const key = ((sum % value) + value) % value;
        map.set(key, (map.get(key) || 0) + 1);
    }

    let missing = 0;
    while (map.get(missing % value) > 0) {
        map.set(missing % value, map.get(missing % value) - 1);
        missing++;
    }

    return missing;
}