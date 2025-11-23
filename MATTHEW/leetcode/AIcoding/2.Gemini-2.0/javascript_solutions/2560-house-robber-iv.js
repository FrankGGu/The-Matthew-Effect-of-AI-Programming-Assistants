var minCapability = function(nums, k) {
    let left = 1;
    let right = Math.max(...nums);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let count = 0;
        let robbed = false;

        for (let i = 0; i < nums.length; i++) {
            if (nums[i] <= mid && !robbed) {
                count++;
                robbed = true;
            } else {
                robbed = false;
            }
        }

        if (count >= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};