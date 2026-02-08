function minOperations(A, K) {
    A.sort((a, b) => a - b);
    let n = A.length;
    let mid = A[Math.floor(n / 2)];
    let operations = 0;

    for (let num of A) {
        operations += Math.abs(num - K);
    }

    return operations;
}