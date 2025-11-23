int minimumOperations(int start, int target) {
    if (start >= target) return start - target;
    int ops = 0;
    while (start < target) {
        if (target % 2 == 0 && target / 2 >= start) {
            target /= 2;
        } else {
            target -= 1;
        }
        ops++;
    }
    return ops + (start - target);
}