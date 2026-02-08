var evenOddBit = function(n) {
    let evenCount = 0;
    let oddCount = 0;
    let bitPosition = 0;

    while (n > 0) {
        if (n % 2 === 1) {
            if (bitPosition % 2 === 0) {
                evenCount++;
            } else {
                oddCount++;
            }
        }
        n = Math.floor(n / 2);
        bitPosition++;
    }

    return [evenCount, oddCount];
};