int calculate(int a, int b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return a / b;
        default: return 0;
    }
}

int calculateChallenge(int a, int b, char op1, char op2) {
    int firstResult = calculate(a, b, op1);
    return calculate(firstResult, b, op2);
}