var isGood = function(nums) {
    const n = Math.max(...nums);
    if (nums.length !== n + 1) return false;

    const count = new Array(n + 1).fill(0);
    for (const num of nums) {
        if (num > n) return false;
        count[num]++;
        if (num < n && count[num] > 1) return false;
        if (num === n && count[num] > 2) return false;
    }
    return count[n] === 2;
};