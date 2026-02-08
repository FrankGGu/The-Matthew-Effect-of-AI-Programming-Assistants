var splitArray = function(nums, k) {
    let low = 0;
    let high = 0;
    for (let num of nums) {
        low = Math.max(low, num);
        high += num;
    }

    let ans = high;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);

        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;

    function check(maxSum) {
        let count = 1;
        let currentSum = 0;
        for (let num of nums) {
            if (currentSum + num > maxSum) {
                count++;
                currentSum = num;
            } else {
                currentSum += num;
            }
        }
        return count <= k;
    }
};