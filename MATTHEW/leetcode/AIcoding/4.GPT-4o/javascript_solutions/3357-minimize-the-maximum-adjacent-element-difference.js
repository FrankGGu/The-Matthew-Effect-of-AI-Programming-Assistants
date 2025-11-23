function minimizeArrayValue(nums) {
    let left = 0, right = Math.max(...nums);

    const canAchieve = (target) => {
        let excess = 0;
        for (let num of nums) {
            if (num > target) {
                excess += num - target;
            } else {
                excess = Math.max(0, excess - (target - num));
            }
            if (excess < 0) return false;
        }
        return true;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canAchieve(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}