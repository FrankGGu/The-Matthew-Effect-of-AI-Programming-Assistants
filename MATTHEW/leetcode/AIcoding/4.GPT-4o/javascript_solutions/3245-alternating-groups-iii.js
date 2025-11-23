function alternatingGroupsIII(A) {
    let n = A.length;
    let result = [];
    let group = [];

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            group.push(A[i]);
        } else {
            if (group.length > 0) {
                result.push(group);
            }
            group = [A[i]];
        }
    }

    if (group.length > 0) {
        result.push(group);
    }

    return result;
}