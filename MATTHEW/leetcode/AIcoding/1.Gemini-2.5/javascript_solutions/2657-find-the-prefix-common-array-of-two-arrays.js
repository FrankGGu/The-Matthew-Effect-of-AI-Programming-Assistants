var findThePrefixCommonArray = function(A, B) {
    const n = A.length;
    const P = new Array(n);
    const seenA = new Set();
    const seenB = new Set();
    let commonCount = 0;

    for (let i = 0; i < n; i++) {
        const numA = A[i];
        const numB = B[i];

        // Process numA
        if (!seenA.has(numA)) {
            if (seenB.has(numA)) {
                commonCount++;
            }
            seenA.add(numA);
        }

        // Process numB
        if (!seenB.has(numB)) {
            if (seenA.has(numB)) {
                commonCount++;
            }
            seenB.add(numB);
        }

        P[i] = commonCount;
    }

    return P;
};