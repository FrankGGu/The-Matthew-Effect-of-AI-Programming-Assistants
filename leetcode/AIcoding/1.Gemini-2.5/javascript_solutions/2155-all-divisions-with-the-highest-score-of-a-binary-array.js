var maxScoreIndices = function(nums) {
    let n = nums.length;
    let leftZeros = 0;
    let rightOnes = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            rightOnes++;
        }
    }

    let maxScore = -1;
    let result = [];

    for (let i = 0; i <= n; i++) {
        let currentScore = leftZeros + rightOnes;

        if (currentScore > maxScore) {
            maxScore = currentScore;
            result = [i];
        } else if (currentScore === maxScore) {
            result.push(i);
        }

        if (i < n) {
            if (nums[i] === 0) {
                leftZeros++;
            } else {
                rightOnes--;
            }
        }
    }

    return result;
};