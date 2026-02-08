var maxDivScore = function(nums, divisors) {
    let maxScore = -1;
    let result = -1;

    for (let i = 0; i < divisors.length; i++) {
        let divisor = divisors[i];
        let score = 0;
        for (let j = 0; j < nums.length; j++) {
            if (nums[j] % divisor === 0) {
                score++;
            }
        }

        if (score > maxScore) {
            maxScore = score;
            result = divisor;
        } else if (score === maxScore) {
            result = Math.min(result, divisor);
        }
    }

    return result;
};