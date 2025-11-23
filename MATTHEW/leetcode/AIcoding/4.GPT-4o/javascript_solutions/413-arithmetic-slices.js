var numberOfArithmeticSlices = function(A) {
    let count = 0, total = 0;
    for (let i = 2; i < A.length; i++) {
        if (A[i] - A[i - 1] === A[i - 1] - A[i - 2]) {
            count++;
            total += count;
        } else {
            count = 0;
        }
    }
    return total;
};