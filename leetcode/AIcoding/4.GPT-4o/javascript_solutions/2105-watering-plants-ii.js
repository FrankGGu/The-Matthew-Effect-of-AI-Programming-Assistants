var minimumHours = function(A, B, C) {
    let totalWater = 0;
    let distance = 0;

    for (let i = 0; i < A.length; i++) {
        totalWater += A[i];
        distance += B[i];
    }

    let totalTime = Math.ceil(totalWater / C) + distance;
    return totalTime;
};