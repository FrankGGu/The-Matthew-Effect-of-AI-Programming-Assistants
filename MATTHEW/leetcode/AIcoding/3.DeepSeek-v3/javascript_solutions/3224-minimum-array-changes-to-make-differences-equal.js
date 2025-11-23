var minChanges = function(nums) {
    const n = nums.length;
    if (n === 1) return 0;

    const diff = [];
    for (let i = 1; i < n; i++) {
        diff.push(nums[i] - nums[i - 1]);
    }

    const uniqueDiffs = new Set(diff);
    if (uniqueDiffs.size === 1) return 0;
    if (uniqueDiffs.size > 2) return -1;

    const [d1, d2] = Array.from(uniqueDiffs);
    let count1 = 0, count2 = 0;
    for (const d of diff) {
        if (d === d1) count1++;
        else count2++;
    }

    if (count1 === 1 || count2 === 1) {
        return 1;
    } else {
        return -1;
    }
};