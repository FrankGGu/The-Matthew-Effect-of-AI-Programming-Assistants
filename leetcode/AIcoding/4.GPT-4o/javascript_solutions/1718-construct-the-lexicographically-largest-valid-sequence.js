function constructSequence(n) {
    const result = [];
    for (let i = n; i > 0; i--) {
        result.push(i);
        if (i > 1) {
            result.push(i - 1);
        }
    }
    return result;
}