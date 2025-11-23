function difference(nums, k) {
    const set = new Set(nums);
    let count = 0;
    for (const num of nums) {
        if (set.has(num + k) && set.has(num + 2 * k)) {
            count++;
        }
    }
    return count;
}