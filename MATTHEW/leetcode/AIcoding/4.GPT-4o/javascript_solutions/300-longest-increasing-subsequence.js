var lengthOfLIS = function(nums) {
    const dp = [];
    for (let num of nums) {
        let left = 0, right = dp.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] < num) left = mid + 1;
            else right = mid;
        }
        dp[left] = num;
        if (left === dp.length) dp.push(num);
    }
    return dp.length;
};