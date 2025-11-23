function smallestNumberWithAllSetBits(n) {
    let num = 1;
    while (num <= n) {
        num = (num << 1) | 1;
    }
    return num - 1;
}