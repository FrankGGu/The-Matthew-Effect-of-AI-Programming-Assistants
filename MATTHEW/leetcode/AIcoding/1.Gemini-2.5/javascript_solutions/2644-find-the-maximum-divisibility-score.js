var maxDivisibilityScore = function(nums, divisors) {
    let maxScore = -1;
    let resultDivisor = Infinity;

    for (let i = 0; i < divisors.length; i++) {
        const currentDivisor = divisors[i];
        let currentScore = 0;

        for (let j = 0; j < nums.length; j++) {
            if (nums[j] % currentDivisor === 0) {
                currentScore++;
            }
        }

        if (currentScore > maxScore) {
            maxScore = currentScore;
            resultDivisor = currentDivisor;
        } else if (currentScore === maxScore) {
            resultDivisor = Math.min(resultDivisor, currentDivisor);
        }
    }

    return resultDivisor;
};