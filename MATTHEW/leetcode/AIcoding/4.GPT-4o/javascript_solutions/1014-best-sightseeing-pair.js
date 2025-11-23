var maxScoreSightseeingPair = function(A) {
    let maxScore = 0;
    let maxI = A[0];

    for (let j = 1; j < A.length; j++) {
        maxScore = Math.max(maxScore, maxI + A[j] - j);
        maxI = Math.max(maxI, A[j] + j);
    }

    return maxScore;
};