function evenOddBit(n) {
    let evenCount = 0, oddCount = 0;
    const bits = n.toString(2).split('').reverse();

    for (let i = 0; i < bits.length; i++) {
        if (bits[i] === '1') {
            if (i % 2 === 0) evenCount++;
            else oddCount++;
        }
    }

    return [evenCount, oddCount];
}