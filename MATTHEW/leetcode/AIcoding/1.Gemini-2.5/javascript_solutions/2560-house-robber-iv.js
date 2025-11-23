var minCapability = function(nums, k) {
    let low = 0;
    let high = 0;
    for (let i = 0; i < nums.length; i++) {
        high = Math.max(high, nums[i]);
    }

    let ans = high;

    const check = (capacity) => {
        let count = 0;
        let i = 0;
        while (i < nums.length) {
            if (nums[i] <= capacity) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return count >= k;
    };

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};