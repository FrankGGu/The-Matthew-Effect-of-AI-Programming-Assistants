function countOperations(a, b) {
    let count = 0;
    while (a > 0 && b > 0) {
        if (a >= b) {
            a -= b;
        } else {
            b -= a;
        }
        count++;
    }
    return count;
}