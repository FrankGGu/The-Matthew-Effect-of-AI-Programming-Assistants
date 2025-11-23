var findThePrefixCommonArray = function(A, B) {
    const n = A.length;
    const C = [];
    const setA = new Set();
    const setB = new Set();

    for (let i = 0; i < n; i++) {
        setA.add(A[i]);
        setB.add(B[i]);
        let count = 0;

        for (const num of setA) {
            if (setB.has(num)) {
                count++;
            }
        }

        C.push(count);
    }

    return C;
};