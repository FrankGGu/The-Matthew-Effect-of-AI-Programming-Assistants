var smallestDivisor = function(nums, threshold) {
    let left = 1;
    let right = Math.max(...nums);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const sum = nums.reduce((acc, num) => acc + Math.ceil(num / mid), 0);

        if (sum > threshold) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};