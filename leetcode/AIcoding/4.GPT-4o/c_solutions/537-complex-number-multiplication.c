char * complexNumberMultiply(char * num1, char * num2) {
    int a, b, c, d;
    sscanf(num1, "%d+%di", &a, &b);
    sscanf(num2, "%d+%di", &c, &d);
    int real = a * c - b * d;
    int imag = a * d + b * c;
    char *result = (char *)malloc(50);
    sprintf(result, "%d+%di", real, imag);
    return result;
}