var maxFactorScore = function(nums) {
    let maxScore = 0;

    for (let num of nums) {
        let score = 0;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                score++;
                while (num % i === 0) {
                    num /= i;
                }
            }
        }
        if (num > 1) {
            score++;
        }
        maxScore = Math.max(maxScore, score);
    }

    return maxScore;
};