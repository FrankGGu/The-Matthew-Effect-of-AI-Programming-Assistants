int punishmentNumber(int n) {
    int res = 0;
    for (int i = 1; i <= n; i++) {
        int square = i * i;
        if (canPartition(square, i)) {
            res += square;
        }
    }
    return res;
}

bool canPartition(int num, int target) {
    if (num < target) return false;
    if (num == target) return true;

    int base = 10;
    while (base <= num) {
        int remainder = num % base;
        int quotient = num / base;
        if (canPartition(quotient, target - remainder)) {
            return true;
        }
        base *= 10;
    }
    return false;
}