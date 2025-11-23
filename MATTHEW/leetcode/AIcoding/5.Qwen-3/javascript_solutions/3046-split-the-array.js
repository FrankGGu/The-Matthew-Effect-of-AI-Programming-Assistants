function splitArray(nums, m) {
    function canSplit(maxSum) {
        let count = 1;
        let currentSum = 0;
        for (const num of nums) {
            currentSum += num;
            if (currentSum > maxSum) {
                count++;
                currentSum = num;
                if (count > m) return false;
            }
        }
        return true;
    }

    let left = Math.max(...nums);
    let right = nums.reduce((a, b) => a + b, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canSplit(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}