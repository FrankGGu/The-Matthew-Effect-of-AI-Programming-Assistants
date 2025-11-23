var maximizeTheMinimumScore = function(nums, k) {
    let left = Math.min(...nums);
    let right = Math.max(...nums);
    let result = left;

    const isPossible = (minScore) => {
        let operations = k;
        for (let num of nums) {
            if (num < minScore) {
                operations -= (minScore - num);
                if (operations < 0) return false;
            }
        }
        return true;
    };

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (isPossible(mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};