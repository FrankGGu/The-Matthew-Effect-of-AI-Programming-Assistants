function isGood(nums) {
    const n = nums.length;
    const expected = new Set();
    for (let i = 1; i <= n - 1; i++) {
        expected.add(i);
    }
    const set = new Set(nums);
    return set.size === n - 1 && [...set].every(num => expected.has(num));
}