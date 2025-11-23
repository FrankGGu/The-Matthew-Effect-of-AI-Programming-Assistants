int balancedStringSplit(char* s) {
    int count = 0;
    int balance = 0;

    while (*s) {
        if (*s == 'L') {
            balance++;
        } else {
            balance--;
        }

        if (balance == 0) {
            count++;
        }

        s++;
    }

    return count;
}