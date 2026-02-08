var lengthOfLIS = function(nums, k) {
    const dp = [];

    for (const num of nums) {
        let left = 0;
        let right = dp.length;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid][0] < num) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        let currentLength = 1;
        if (left > 0) {
            currentLength = dp[left - 1][1] + 1;
        }

        let insertIndex = dp.length;
        for(let i = 0; i < dp.length; ++i){
            if(dp[i][0] > num && dp[i][0] <= num + k){
                insertIndex = i;
                break;
            }
        }

        if(insertIndex < dp.length && dp[insertIndex][1] >= currentLength) continue;

        let newEntry = [num, currentLength];
        dp.splice(insertIndex, 0, newEntry);

        let removeIndex = insertIndex + 1;
        while(removeIndex < dp.length && dp[removeIndex][1] <= currentLength){
            dp.splice(removeIndex, 1);
        }

    }

    if (dp.length === 0) {
        return 0;
    }

    return dp[dp.length - 1][1];
};