var findTheMaximumFactorScore = function(nums) {
    let maxScore = -1;
    let resultNum = -1;

    for (const num of nums) {
        let currentScore = 0;

        // Calculate factors up to sqrt(num)
        for (let i = 1; i * i <= num; i++) {
            if (num % i === 0) {
                let factor1 = i;
                let factor2 = num / i;

                // Add factor1 if it's not the number itself
                if (factor1 !== num) {
                    currentScore += factor1;
                }

                // Add factor2 if it's not the number itself AND it's distinct from factor1
                // This handles perfect squares (factor1 == factor2) and ensures num itself is not added
                if (factor2 !== num && factor1 !== factor2) {
                    currentScore += factor2;
                }
            }
        }

        // Compare current number's score with maxScore
        if (currentScore > maxScore) {
            maxScore = currentScore;
            resultNum = num;
        } else if (currentScore === maxScore) {
            // If scores are equal, choose the smaller number
            resultNum = Math.min(resultNum, num);
        }
    }

    return resultNum;
};