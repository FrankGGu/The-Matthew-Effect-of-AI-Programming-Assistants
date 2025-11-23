int minimizeXor(int num1, int num2) {
    int count = 0;
    for (int i = 0; i < 32; i++) {
        if (num2 & (1 << i)) count++;
    }

    int result = 0;
    for (int i = 31; i >= 0 && count > 0; i--) {
        if (num1 & (1 << i)) {
            result |= (1 << i);
        } else if (count > 0) {
            result |= (1 << i);
            count--;
        }
    }

    return result;
}