var intervalIntersection = function(A, B) {
    let result = [];
    let i = 0, j = 0;

    while (i < A.length && j < B.length) {
        let startA = A[i][0], endA = A[i][1];
        let startB = B[j][0], endB = B[j][1];

        if (endA >= startB && endB >= startA) {
            result.push([Math.max(startA, startB), Math.min(endA, endB)]);
        }

        if (endA < endB) {
            i++;
        } else {
            j++;
        }
    }

    return result;
};