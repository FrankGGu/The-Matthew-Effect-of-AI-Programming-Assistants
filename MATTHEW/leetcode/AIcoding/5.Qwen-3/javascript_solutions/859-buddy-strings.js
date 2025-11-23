function buddyStrings(A, B) {
    if (A.length !== B.length) return false;
    let diff = [];
    for (let i = 0; i < A.length; i++) {
        if (A[i] !== B[i]) {
            diff.push(i);
            if (diff.length > 2) return false;
        }
    }
    return diff.length === 2 && A[diff[0]] === B[diff[1]] && A[diff[1]] === B[diff[0]];
}