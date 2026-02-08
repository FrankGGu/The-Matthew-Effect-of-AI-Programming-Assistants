var maxScoreIndices = function(nums) {
    let leftZeros = 0;
    let rightOnes = nums.reduce((acc, num) => acc + num, 0);
    let maxScore = leftZeros + rightOnes;
    let result = [0];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            leftZeros++;
        } else {
            rightOnes--;
        }
        const currentScore = leftZeros + rightOnes;
        if (currentScore > maxScore) {
            maxScore = currentScore;
            result = [i + 1];
        } else if (currentScore === maxScore) {
            result.push(i + 1);
        }
    }

    return result;
};