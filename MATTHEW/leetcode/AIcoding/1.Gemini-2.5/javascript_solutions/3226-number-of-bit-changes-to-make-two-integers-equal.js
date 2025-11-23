var minBitChanges = function(n, k) {
    let xor_result = n ^ k;
    let count = 0;

    while (xor_result > 0) {
        xor_result &= (xor_result - 1);
        count++;
    }

    return count;
};