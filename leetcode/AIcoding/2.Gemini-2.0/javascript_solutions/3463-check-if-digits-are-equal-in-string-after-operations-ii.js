var checkIfDigitsAreEqual = function(s, queries) {
    const n = s.length;
    const result = [];

    for (const query of queries) {
        let l1 = query[0];
        let r1 = query[1];
        let l2 = query[2];
        let r2 = query[3];

        let sub1 = s.substring(l1, r1 + 1);
        let sub2 = s.substring(l2, r2 + 1);

        if (sub1.length !== sub2.length) {
            result.push(false);
            continue;
        }

        let equal = true;
        for (let i = 0; i < sub1.length; i++) {
            if (sub1[i] !== sub2[i]) {
                equal = false;
                break;
            }
        }

        result.push(equal);
    }

    return result;
};