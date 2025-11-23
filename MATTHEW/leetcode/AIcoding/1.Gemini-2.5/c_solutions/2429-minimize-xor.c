int minimizeXor(int num1, int num2) {
    int k = num2; 
    int x = 0;

    for (int i = 30; i >= 0; --i) {
        if (k == 0) {
            break;
        }

        if ((num1 >> i) & 1) {
            x |= (1 << i);
            k--;
        }
    }

    for (int i = 0; i <= 30; ++i) {
        if (k == 0) {
            break;
        }

        if (!((num1 >> i) & 1) && !((x >> i) & 1)) {
            x |= (1 << i);
            k--;
        }
    }

    return x;
}