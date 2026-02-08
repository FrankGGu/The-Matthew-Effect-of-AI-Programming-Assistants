var sumEvenAfterQueries = function(A, queries) {
    let evenSum = A.filter(x => x % 2 === 0).reduce((a, b) => a + b, 0);
    const result = [];

    for (const [val, index] of queries) {
        if (A[index] % 2 === 0) {
            evenSum -= A[index];
        }
        A[index] += val;
        if (A[index] % 2 === 0) {
            evenSum += A[index];
        }
        result.push(evenSum);
    }

    return result;
};