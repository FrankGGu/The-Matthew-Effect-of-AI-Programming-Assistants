function prefixesDivBy5(A) {
    let prefix = 0;
    const result = [];
    for (let i = 0; i < A.length; i++) {
        prefix = (prefix * 2 + A[i]) % 10;
        result.push(prefix % 5 === 0);
    }
    return result;
}