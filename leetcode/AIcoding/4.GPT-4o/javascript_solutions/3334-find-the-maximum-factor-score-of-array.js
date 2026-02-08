function maxFactorScore(nums) {
    const maxNum = Math.max(...nums);
    const factorCount = new Array(maxNum + 1).fill(0);

    for (let num of nums) {
        for (let j = 1; j <= Math.sqrt(num); j++) {
            if (num % j === 0) {
                factorCount[j]++;
                if (j !== num / j) {
                    factorCount[num / j]++;
                }
            }
        }
    }

    let maxScore = 0;
    for (let i = 1; i < factorCount.length; i++) {
        maxScore = Math.max(maxScore, factorCount[i] * i);
    }

    return maxScore;
}