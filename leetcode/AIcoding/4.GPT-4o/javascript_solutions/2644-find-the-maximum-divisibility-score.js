function maxDivScore(nums, divisor) {
    let maxScore = 0;
    let maxNum = 0;

    for (let num of nums) {
        if (num % divisor === 0) {
            let score = num / divisor;
            if (score > maxScore || (score === maxScore && num > maxNum)) {
                maxScore = score;
                maxNum = num;
            }
        }
    }

    return maxNum;
}