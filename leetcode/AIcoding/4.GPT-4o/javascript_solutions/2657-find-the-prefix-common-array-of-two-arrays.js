var findThePrefixCommonArray = function(A, B) {
    let result = [];
    let countA = 0, countB = 0;

    for (let i = 0; i < A.length; i++) {
        if (A[i] === B[i]) {
            countA++;
        }
        countB += B.slice(0, i + 1).includes(A[i]) ? 1 : 0;
        result.push(countA + countB);
    }

    return result;
};