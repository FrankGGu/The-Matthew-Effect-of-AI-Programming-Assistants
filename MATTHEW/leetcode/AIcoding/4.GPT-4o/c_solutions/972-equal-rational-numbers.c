bool isRationalEqual(char * S, char * T) {
    double num1 = strtod(S, NULL);
    double num2 = strtod(T, NULL);
    return fabs(num1 - num2) < 1e-9;
}