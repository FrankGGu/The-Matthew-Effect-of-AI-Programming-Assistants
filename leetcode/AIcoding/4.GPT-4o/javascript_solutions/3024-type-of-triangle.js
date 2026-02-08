function triangleType(a, b, c) {
    if (a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a) {
        return 0;
    }
    if (a === b && b === c) {
        return 1;
    }
    if (a === b || b === c || a === c) {
        return 2;
    }
    return 3;
}