var minimalKSum = function(A, K) {
    const uniqueNums = new Set(A);
    let sum = 0;
    let count = 0;
    let current = 1;

    while (count < K) {
        if (!uniqueNums.has(current)) {
            sum += current;
            count++;
        }
        current++;
    }

    return sum;
};