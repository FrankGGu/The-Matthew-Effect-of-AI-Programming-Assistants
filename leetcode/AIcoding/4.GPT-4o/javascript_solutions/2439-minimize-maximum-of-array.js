var minimizeArrayValue = function(nums) {
    let left = Math.max(...nums), right = 1e9;

    while (left > right) {
        const mid = Math.floor((left + right) / 2);
        let sum = 0, count = 0;

        for (let num of nums) {
            sum += Math.min(num, mid);
            count += Math.max(0, num - mid);
        }

        if (sum + count <= mid * nums.length) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};