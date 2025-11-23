var minIncrementForUnique = function(A) {
    A.sort((a, b) => a - b);
    let moves = 0;
    for (let i = 1; i < A.length; i++) {
        if (A[i] <= A[i - 1]) {
            moves += A[i - 1] - A[i] + 1;
            A[i] = A[i - 1] + 1;
        }
    }
    return moves;
};