int numSteps(char *s) {
    int steps = 0, carry = 0, len = strlen(s);

    for (int i = len - 1; i > 0; i--) {
        steps += (s[i] - '0') + carry; 
        carry = (s[i] - '0') ? 1 : 0; 
    }

    steps += carry; 
    return steps;
}