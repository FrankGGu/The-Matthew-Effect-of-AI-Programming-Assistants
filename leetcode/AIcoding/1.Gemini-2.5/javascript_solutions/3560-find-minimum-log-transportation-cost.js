var splitArray = function(nums, k) {
    let left = 0;
    let right = 0;
    for (const num of nums) {
        left = Math.max(left, num);
        right += num;
    }

    let ans = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);

        let currentSum = 0;
        let numSubarrays = 1;
        for (const num of nums) {
            if (currentSum + num > mid) {
                numSubarrays++;
                currentSum = num;
            } else {
                currentSum += num;
            }
        }

        if (numSubarrays <= k) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};