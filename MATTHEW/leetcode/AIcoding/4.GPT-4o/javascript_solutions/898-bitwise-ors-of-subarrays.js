var subarrayBitwiseORs = function(A) {
    const result = new Set();
    let current = new Set();
    let prev = 0;

    for (const num of A) {
        current = new Set([num]);
        for (const val of result) {
            current.add(val | num);
        }
        result.add(num);
        for (const val of current) {
            result.add(val);
        }
    }

    return result.size;
};