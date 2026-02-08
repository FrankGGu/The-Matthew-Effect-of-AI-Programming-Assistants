bool reorderedPowerOf2(int n) {
    int count[10] = {0};
    int num = n;

    while (num > 0) {
        count[num % 10]++;
        num /= 10;
    }

    for (int i = 0; i < 31; i++) {
        int power = 1 << i;
        int powerCount[10] = {0};
        num = power;

        while (num > 0) {
            powerCount[num % 10]++;
            num /= 10;
        }

        bool isSame = true;
        for (int j = 0; j < 10; j++) {
            if (count[j] != powerCount[j]) {
                isSame = false;
                break;
            }
        }
        if (isSame) return true;
    }

    return false;
}