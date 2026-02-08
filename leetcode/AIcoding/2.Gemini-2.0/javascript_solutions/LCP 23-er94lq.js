var canReorderDoubled = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    nums.sort((a, b) => Math.abs(a) - Math.abs(b));

    for (const num of nums) {
        if (count[num] === 0) continue;

        const doubled = num * 2;
        if (count[doubled] > 0) {
            count[num]--;
            count[doubled]--;
        } else {
            return false;
        }
    }

    return true;
};