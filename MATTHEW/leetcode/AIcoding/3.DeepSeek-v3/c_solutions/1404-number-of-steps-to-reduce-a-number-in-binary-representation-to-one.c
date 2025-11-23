int numSteps(char* s) {
    int steps = 0;
    int carry = 0;
    int len = strlen(s);

    for (int i = len - 1; i > 0; i--) {
        if (s[i] - '0' + carry == 1) {
            steps += 2;
            carry = 1;
        } else {
            steps += 1;
        }
    }

    return steps + carry;
}