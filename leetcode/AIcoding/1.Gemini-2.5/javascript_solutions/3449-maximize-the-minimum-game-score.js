var maximizeTheMinimumGameScore = function(nums, k) {
    const check = (minScore) => {
        let currentSum = 0;
        let subarraysCount = 0;
        for (let i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            if (currentSum >= minScore) {
                subarraysCount++;
                currentSum = 0;
            }
        }
        return subarraysCount >= k;
    };

    let low = 0;
    let high = 0;
    for (let i = 0; i < nums.length; i++) {
        high += nums[i];
    }

    let ans = 0;
    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};