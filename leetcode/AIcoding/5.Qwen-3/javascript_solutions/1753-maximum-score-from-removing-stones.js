function maximumScore(a, b, c) {
    const min = Math.min(a, b, c);
    const sum = a + b + c;
    if (sum - min <= min) {
        return sum - min;
    } else {
        return Math.floor((sum) / 2);
    }
}