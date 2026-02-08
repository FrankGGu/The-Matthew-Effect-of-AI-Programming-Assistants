var sumOfSubarrayLengths = function(A) {
    let total = 0, n = A.length;
    for (let i = 0; i < n; i++) {
        let length = 0;
        for (let j = i; j < n; j++) {
            length++;
            total += length;
        }
    }
    return total;
};