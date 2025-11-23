function smallestNumberWithAllSetBits(n) {
    if (n === 0) return 0;
    let bits = n.toString(2).length;
    return (1 << bits) - 1;
}