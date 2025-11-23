var maxScoreSightseeingPair = function(A) {
    let maxScore = -Infinity;
    let max_A_plus_i = A[0] + 0;

    for (let j = 1; j < A.length; j++) {
        maxScore = Math.max(maxScore, max_A_plus_i + (A[j] - j));
        max_A_plus_i = Math.max(max_A_plus_i, A[j] + j);
    }

    return maxScore;
};