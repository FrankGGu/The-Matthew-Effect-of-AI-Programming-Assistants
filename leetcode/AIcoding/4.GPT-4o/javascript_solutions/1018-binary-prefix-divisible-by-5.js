var prefixesDivBy5 = function(A) {
    let result = [];
    let current = 0;
    for (let i = 0; i < A.length; i++) {
        current = ((current << 1) + A[i]) % 5;
        result.push(current === 0);
    }
    return result;
};