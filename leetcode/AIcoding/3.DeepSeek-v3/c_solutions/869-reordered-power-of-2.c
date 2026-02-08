bool compareCount(int* count1, int* count2) {
    for (int i = 0; i < 10; i++) {
        if (count1[i] != count2[i]) return false;
    }
    return true;
}

bool reorderedPowerOf2(int n) {
    int count[10] = {0};
    while (n > 0) {
        count[n % 10]++;
        n /= 10;
    }

    for (int i = 0; i < 31; i++) {
        int power = 1 << i;
        int powerCount[10] = {0};
        while (power > 0) {
            powerCount[power % 10]++;
            power /= 10;
        }
        if (compareCount(count, powerCount)) return true;
    }
    return false;
}