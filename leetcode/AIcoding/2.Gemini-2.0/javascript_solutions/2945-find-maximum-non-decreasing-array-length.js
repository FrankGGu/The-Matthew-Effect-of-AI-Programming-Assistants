var findMaximumNonDecreasingArrayLength = function(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    let sum = 0;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        sum += nums[i];
        dp[i] = nums[i];
        if (i > 0) {
            dp[i] = Math.max(dp[i], dp[i - 1]);
        }
        if (sum >= dp[i]) {
            if (i > 0 && sum - nums[i] >= dp[i - 1]) {
                dp[i] = sum;
                ans = Math.max(ans, i + 1);
            } else if(i === 0){
                dp[i] = sum;
                ans = Math.max(ans, i + 1);
            } else if(sum - nums[i] >= nums[i-1]){
                 dp[i] = sum;
                ans = Math.max(ans, i + 1);
            }
        } else {
            sum -= nums[i];
        }

    }

    if(ans === 0){
        let currentSum = 0;
        let count = 0;
        let prev = 0;
        for(let i=0; i< n; i++){
            currentSum += nums[i];
            if(currentSum >= prev){
                count++;
                prev = currentSum;
                currentSum = 0;
            }
        }
        return count;
    }
    return ans;
};