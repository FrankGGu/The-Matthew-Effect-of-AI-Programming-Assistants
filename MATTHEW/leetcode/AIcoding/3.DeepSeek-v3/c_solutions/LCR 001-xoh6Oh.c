int divide(int dividend, int divisor) {
    if (dividend == INT_MIN && divisor == -1) {
        return INT_MAX;
    }

    long long a = llabs((long long)dividend);
    long long b = llabs((long long)divisor);
    int sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1;

    long long result = 0;
    while (a >= b) {
        long long temp = b, multiple = 1;
        while (a >= (temp << 1)) {
            temp <<= 1;
            multiple <<= 1;
        }
        a -= temp;
        result += multiple;
    }

    result = sign * result;
    if (result > INT_MAX) return INT_MAX;
    if (result < INT_MIN) return INT_MIN;
    return result;
}