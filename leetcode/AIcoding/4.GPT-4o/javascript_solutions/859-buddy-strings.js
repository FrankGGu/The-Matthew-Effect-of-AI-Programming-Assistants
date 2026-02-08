var buddyStrings = function(A, B) {
    if (A.length !== B.length) return false;
    if (A === B) {
        const seen = new Set();
        for (let char of A) {
            if (seen.has(char)) return true;
            seen.add(char);
        }
        return false;
    }

    let pairs = [];
    for (let i = 0; i < A.length; i++) {
        if (A[i] !== B[i]) {
            pairs.push([A[i], B[i]]);
        }
    }

    return pairs.length === 2 && pairs[0][0] === pairs[1][1] && pairs[0][1] === pairs[1][0];
};