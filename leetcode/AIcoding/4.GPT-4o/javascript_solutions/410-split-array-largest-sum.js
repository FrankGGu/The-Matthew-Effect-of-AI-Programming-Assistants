var splitArray = function(nums, m) {
    let left = Math.max(...nums), right = nums.reduce((a, b) => a + b, 0);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let count = 1, sum = 0;

        for (let num of nums) {
            sum += num;
            if (sum > mid) {
                count++;
                sum = num;
            }
        }

        if (count <= m) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};