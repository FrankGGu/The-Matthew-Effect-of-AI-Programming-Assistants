var splitArray = function(nums, k) {
    let left = Math.max(...nums);
    let right = nums.reduce((sum, num) => sum + num, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let count = 1;
        let currentSum = 0;

        for (let num of nums) {
            if (currentSum + num > mid) {
                count++;
                currentSum = num;
            } else {
                currentSum += num;
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