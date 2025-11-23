function distributeRepeatingIntegers(nums) {
    const count = {};
    nums.forEach(num => count[num] = (count[num] || 0) + 1);

    const distinctCount = Object.keys(count).length;
    const n = nums.length;

    return Math.min(distinctCount, n / 2);
}