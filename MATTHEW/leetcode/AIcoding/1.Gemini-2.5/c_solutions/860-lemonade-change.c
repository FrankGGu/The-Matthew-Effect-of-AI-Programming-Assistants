bool lemonadeChange(int* bills, int billsSize) {
    int fives = 0;
    int tens = 0;

    for (int i = 0; i < billsSize; i++) {
        if (bills[i] == 5) {
            fives++;
        } else if (bills[i] == 10) {
            if (fives == 0) {
                return false;
            }
            fives--;
            tens++;
        } else { // bills[i] == 20
            if (tens > 0 && fives > 0) {
                tens--;
                fives--;
            } else if (fives >= 3) {
                fives -= 3;
            } else {
                return false;
            }
        }
    }

    return true;
}