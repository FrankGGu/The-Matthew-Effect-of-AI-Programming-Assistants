function longestSubsequenceWithLimitedSum(nums, queries) {
    nums.sort((a, b) => a - b);
    const prefix = [];
    let sum = 0;
    for (const num of nums) {
        sum += num;
        prefix.push(sum);
    }
    const result = [];
    for (const q of queries) {
        let left = 0, right = prefix.length - 1;
        let ans = 0;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (prefix[mid] <= q) {
                ans = mid + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result.push(ans);
    }
    return result;
}