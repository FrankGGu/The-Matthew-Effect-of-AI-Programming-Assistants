var minDominoRotations = function(A, B) {
    const n = A.length;

    // Helper function to calculate minimum rotations if 'x' is the target value
    const check = (x) => {
        let rotationsA = 0; // Rotations needed to make all elements in A equal to x
        let rotationsB = 0; // Rotations needed to make all elements in B equal to x

        for (let i = 0; i < n; i++) {
            // If the current domino (A[i], B[i]) cannot form 'x' on either side,
            // then it's impossible to make all elements 'x' for this target.
            if (A[i] !== x && B[i] !== x) {
                return -1;
            }

            // If A[i] is not x, it means B[i] must be x (due to the check above).
            // To make A[i] equal to x, we must rotate this domino.
            if (A[i] !== x) {
                rotationsA++;
            }

            // If B[i] is not x, it means A[i] must be x (due to the check above).
            // To make B[i] equal to x, we must rotate this domino.
            if (B[i] !== x) {
                rotationsB++;
            }
            // If both A[i] === x and B[i] === x, no rotation is needed for either case.
        }

        // Return the minimum rotations required for either row A or row B to become all 'x'.
        return Math.min(rotationsA, rotationsB);
    };

    let result = Infinity;

    // Case 1: Try to make all elements equal to the value A[0]
    let res1 = check(A[0]);
    if (res1 !== -1) {
        result = Math.min(result, res1);
    }

    // Case 2: If A[0] and B[0] are different, also try to make all elements equal to B[0].
    // If A[0] === B[0], then checking B[0] would yield the same result as checking A[0],
    // so we avoid redundant computation.
    if (A[0] !== B[0]) {
        let res2 = check(B[0]);
        if (res2 !== -1) {
            result = Math.min(result, res2);
        }
    }

    // If result is still Infinity, it means no solution was found.
    return result === Infinity ? -1 : result;
};