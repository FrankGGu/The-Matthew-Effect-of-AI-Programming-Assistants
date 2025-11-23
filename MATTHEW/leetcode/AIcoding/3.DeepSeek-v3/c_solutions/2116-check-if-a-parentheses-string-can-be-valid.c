bool canBeValid(char* s, char* locked) {
    int len = strlen(s);
    if (len % 2 != 0) return false;

    int balance = 0;
    for (int i = 0; i < len; i++) {
        if (locked[i] == '0' || s[i] == '(') {
            balance++;
        } else {
            balance--;
        }
        if (balance < 0) return false;
    }

    balance = 0;
    for (int i = len - 1; i >= 0; i--) {
        if (locked[i] == '0' || s[i] == ')') {
            balance++;
        } else {
            balance--;
        }
        if (balance < 0) return false;
    }

    return true;
}