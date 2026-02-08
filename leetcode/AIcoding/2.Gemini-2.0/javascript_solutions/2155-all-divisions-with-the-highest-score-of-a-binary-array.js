var maxScoreIndices = function(nums) {
    let n = nums.length;
    let ones = 0;
    for (let num of nums) {
        if (num === 1) {
            ones++;
        }
    }

    let maxScore = 0;
    let scores = [];
    let zerosLeft = 0;
    let onesRight = ones;

    for (let i = 0; i <= n; i++) {
        let score = zerosLeft + onesRight;
        if (score > maxScore) {
            maxScore = score;
            scores = [i];
        } else if (score === maxScore) {
            scores.push(i);
        }

        if (i < n) {
            if (nums[i] === 0) {
                zerosLeft++;
            } else {
                onesRight--;
            }
        }
    }

    return scores;
};