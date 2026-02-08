function minimumLimitOfBallsInABag(nums, maxOperations) {
    function canAchieve(limit) {
        let operations = 0;
        for (let num of nums) {
            if (num > limit) {
                operations += Math.ceil(num / limit) - 1;
                if (operations > maxOperations) return false;
            }
        }
        return true;
    }

    let left = 1, right = Math.max(...nums);
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canAchieve(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}