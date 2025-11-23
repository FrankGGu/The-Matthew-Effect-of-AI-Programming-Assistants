var evenOddBit = function(n) {
    let evenCount = 0;
    let oddCount = 0;
    let index = 0;

    while (n > 0) {
        if ((n & 1) === 1) {
            if (index % 2 === 0) {
                evenCount++;
            } else {
                oddCount++;
            }
        }
        n >>= 1;
        index++;
    }

    return [evenCount, oddCount];
};