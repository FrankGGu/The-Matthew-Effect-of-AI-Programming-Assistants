var partitionDisjoint = function(A) {
    let maxLeft = A[0], maxGlobal = A[0], partitionIndex = 0;

    for (let i = 1; i < A.length; i++) {
        if (A[i] < maxLeft) {
            partitionIndex = i;
            maxLeft = maxGlobal;
        }
        maxGlobal = Math.max(maxGlobal, A[i]);
    }

    return partitionIndex + 1;
};