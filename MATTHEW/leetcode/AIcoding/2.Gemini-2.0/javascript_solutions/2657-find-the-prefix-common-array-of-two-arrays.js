var findThePrefixCommonArray = function(A, B) {
    const n = A.length;
    const result = new Array(n).fill(0);
    const setA = new Set();
    const setB = new Set();

    for (let i = 0; i < n; i++) {
        setA.add(A[i]);
        setB.add(B[i]);
        let count = 0;
        for(let num of setA) {
            if(setB.has(num)) {
                count++;
            }
        }
        result[i] = count;
    }

    return result;
};