var minOperations = function(nums) {
    const n = nums.length;
    const uniqueNums = [...new Set(nums)].sort((a, b) => a - b);
    let ans = n;
    for (let i = 0; i < uniqueNums.length; i++) {
        let left = uniqueNums[i];
        let right = left + n - 1;
        let j = uniqueNums.length - 1;
        while (j >= 0 && uniqueNums[j] > right) {
            j--;
        }
        let count = j - i + 1;
        ans = Math.min(ans, n - count);
    }
    return ans;
};