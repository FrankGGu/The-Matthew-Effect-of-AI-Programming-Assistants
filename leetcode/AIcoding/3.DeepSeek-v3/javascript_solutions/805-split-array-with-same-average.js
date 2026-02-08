var splitArraySameAverage = function(nums) {
    const n = nums.length;
    const sum = nums.reduce((a, b) => a + b, 0);
    const half = n / 2;
    const possible = new Array(half + 1).fill().map(() => new Set());
    possible[0].add(0);

    for (const num of nums) {
        for (let k = half; k >= 1; --k) {
            for (const sumB of possible[k - 1]) {
                const newSum = sumB + num;
                if (newSum * (n - k) === (sum - newSum) * k) {
                    return true;
                }
                possible[k].add(newSum);
            }
        }
    }

    return false;
};