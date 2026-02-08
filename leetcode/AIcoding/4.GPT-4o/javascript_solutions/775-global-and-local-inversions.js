var isIdealPermutation = function(A) {
    let localInversions = 0;
    for (let i = 0; i < A.length; i++) {
        if (A[i] !== i) {
            localInversions++;
            if (A[i] > A[i + 1]) return false;
        }
    }
    return localInversions === 0 || localInversions === A.length - 1;
};