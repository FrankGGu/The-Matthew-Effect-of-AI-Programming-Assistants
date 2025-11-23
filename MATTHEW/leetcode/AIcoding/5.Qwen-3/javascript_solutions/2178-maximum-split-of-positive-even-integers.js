function maximumSplit(n) {
    const result = [];
    while (n > 2) {
        result.push(2);
        n -= 2;
    }
    if (n === 2) {
        result.push(2);
    }
    return result;
}