function smallestDivisor(nums, threshold) {
    function check(d) {
        let sum = 0;
        for (let num of nums) {
            sum += Math.ceil(num / d);
        }
        return sum <= threshold;
    }

    let left = 1, right = Math.max(...nums);
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (check(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}