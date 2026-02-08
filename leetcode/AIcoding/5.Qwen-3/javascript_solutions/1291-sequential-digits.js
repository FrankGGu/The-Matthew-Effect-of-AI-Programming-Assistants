function sequentialDigits(n) {
    const result = [];
    for (let i = 1; i <= 9; i++) {
        let num = i;
        for (let j = i + 1; j <= 9; j++) {
            num = num * 10 + j;
            if (num >= Math.pow(10, n - 1)) {
                break;
            }
            result.push(num);
        }
    }
    return result.sort((a, b) => a - b);
}