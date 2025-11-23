function avg(arr, i, j) {
    return (arr[i] + arr[j]) / 2;
}

function canSplit(nums, i, j, sum, count, memo) {
    if (i > j) return false;
    if (memo[i][j] !== undefined) return memo[i][j];
    if (count === 0) return true;
    for (let k = i; k <= j; k++) {
        if (sum * count === avg(nums, i, k) * (k - i + 1)) {
            if (canSplit(nums, k + 1, j, sum - nums[k], count - 1, memo)) {
                memo[i][j] = true;
                return true;
            }
        }
    }
    memo[i][j] = false;
    return false;
}

function isSameAverage(nums) {
    const n = nums.length;
    if (n === 1) return false;
    let totalSum = nums.reduce((a, b) => a + b, 0);
    const memo = Array.from({ length: n }, () => Array(n).fill(undefined));
    return canSplit(nums, 0, n - 1, totalSum, n - 1, memo);
}