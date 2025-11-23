var maxDivScore = function(nums, divisors) {
    let maxCount = -1;
    let result = Infinity;

    for (const d of divisors) {
        let count = 0;
        for (const num of nums) {
            if (num % d === 0) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
            result = d;
        } else if (count === maxCount && d < result) {
            result = d;
        }
    }

    return result;
};