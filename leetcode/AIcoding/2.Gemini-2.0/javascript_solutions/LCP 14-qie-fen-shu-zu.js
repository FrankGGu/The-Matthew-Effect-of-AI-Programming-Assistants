var splitArray = function(nums, k) {
    let left = Math.max(...nums);
    let right = nums.reduce((acc, num) => acc + num, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let count = 1;
        let currentSum = 0;

        for (let i = 0; i < nums.length; i++) {
            if (currentSum + nums[i] > mid) {
                count++;
                currentSum = nums[i];
            } else {
                currentSum += nums[i];
            }
        }

        if (count > k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};