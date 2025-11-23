function clumsy(N) {
    if (N === 1) return 1;
    if (N === 2) return 2;
    if (N === 3) return 6;
    let result = N;
    for (let i = N - 1; i > 0; i -= 4) {
        if (i >= 2) {
            result = result - i * (i - 1);
        } else {
            result -= i;
        }
        if (i - 2 >= 1) {
            result *= i - 2;
        }
        if (i - 3 >= 1) {
            result = result / (i - 3);
        }
    }
    return result;
}