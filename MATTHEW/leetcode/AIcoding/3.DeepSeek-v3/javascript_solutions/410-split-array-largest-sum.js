var splitArray = function(nums, m) {
    let left = Math.max(...nums);
    let right = nums.reduce((a, b) => a + b, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let sum = 0;
        let count = 1;

        for (const num of nums) {
            if (sum + num > mid) {
                sum = num;
                count++;
            } else {
                sum += num;
            }
        }

        if (count > m) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};