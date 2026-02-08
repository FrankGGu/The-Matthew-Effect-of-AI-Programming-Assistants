var countWays = function(nums) {
    nums.sort((a, b) => a - b);
    let ways = 0;
    const n = nums.length;

    if (nums[0] > 0) {
        ways++;
    }

    for (let i = 0; i < n; i++) {
        const selected = i + 1;
        if (selected > nums[i]) {
            if (i === n - 1 || selected < nums[i + 1]) {
                ways++;
            }
        }
    }

    return ways;
};