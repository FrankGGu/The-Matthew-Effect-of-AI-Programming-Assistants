var minimizeArrayValue = function(nums) {
    let left = Math.max(...nums);
    let right = 0;

    while (left > right) {
        const mid = Math.floor((left + right) / 2);
        let total = 0;
        let count = 0;

        for (const num of nums) {
            total += Math.min(num, mid);
            count += Math.max(0, num - mid);
        }

        if (total + count >= mid * nums.length) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};