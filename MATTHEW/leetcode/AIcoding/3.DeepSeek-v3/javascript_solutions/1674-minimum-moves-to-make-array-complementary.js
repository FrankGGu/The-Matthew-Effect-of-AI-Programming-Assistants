var minMoves = function(nums, limit) {
    const n = nums.length;
    const diff = new Array(2 * limit + 2).fill(0);

    for (let i = 0; i < n / 2; i++) {
        const a = nums[i];
        const b = nums[n - 1 - i];

        const left = 2;
        const right = 2 * limit;
        diff[left] += 2;
        diff[right + 1] -= 2;

        const min = Math.min(a, b);
        const max = Math.max(a, b);

        const left1 = 1 + min;
        const right1 = limit + max;
        diff[left1] += -1;
        diff[right1 + 1] -= -1;

        const sum = a + b;
        diff[sum] += -1;
        diff[sum + 1] -= -1;
    }

    let res = n;
    let current = 0;
    for (let i = 2; i <= 2 * limit; i++) {
        current += diff[i];
        if (current < res) {
            res = current;
        }
    }
    return res;
};