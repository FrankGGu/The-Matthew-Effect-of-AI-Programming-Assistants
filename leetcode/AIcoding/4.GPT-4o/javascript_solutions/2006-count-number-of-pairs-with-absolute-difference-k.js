function countKDifference(nums, k) {
    let count = 0;
    const map = new Map();

    for (const num of nums) {
        count += (map.get(num - k) || 0) + (map.get(num + k) || 0);
        map.set(num, (map.get(num) || 0) + 1);
    }

    return count;
}