bool canWin(int num) {
    for (int i = 1; i <= 9; i++) {
        if ((num - i) % 10 == 0) {
            return false;
        }
    }
    return true;
}