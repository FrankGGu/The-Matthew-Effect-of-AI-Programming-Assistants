var chaseGame = function(A, B) {
    A.sort((a, b) => a - b);
    B.sort((a, b) => a - b);
    let n = A.length;
    let m = B.length;

    if (n === 0 || m === 0) return false;

    let aMax = A[n - 1];
    let bMax = B[m - 1];

    return aMax < bMax && (m < n || aMax < B[m - 2]);
};