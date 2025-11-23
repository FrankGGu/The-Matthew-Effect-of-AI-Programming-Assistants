function splitArray(nums, m) {
    function canSplit(largest) {
        let count = 1, sum = 0;
        for (const num of nums) {
            sum += num;
            if (sum > largest) {
                count++;
                sum = num;
                if (count > m) return false;
            }
        }
        return true;
    }

    let left = Math.max(...nums), right = nums.reduce((a, b) => a + b, 0);
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