int minimizeXor(int num1, int num2) {
    int count1 = __builtin_popcount(num1);
    int count2 = __builtin_popcount(num2);

    if (count1 == count2) {
        return num1;
    }

    int res = num1;

    if (count1 > count2) {
        int toRemove = count1 - count2;
        for (int i = 0; i < 32 && toRemove > 0; i++) {
            if (res & (1 << i)) {
                res &= ~(1 << i);
                toRemove--;
            }
        }
    } else {
        int toAdd = count2 - count1;
        for (int i = 0; i < 32 && toAdd > 0; i++) {
            if (!(res & (1 << i))) {
                res |= (1 << i);
                toAdd--;
            }
        }
    }

    return res;
}