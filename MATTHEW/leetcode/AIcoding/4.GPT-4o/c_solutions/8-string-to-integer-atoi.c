int myAtoi(char * s) {
    int i = 0, sign = 1, result = 0, num = 0;
    while (s[i] == ' ') i++;
    if (s[i] == '-' || s[i] == '+') {
        sign = (s[i] == '-') ? -1 : 1;
        i++;
    }
    while (s[i] >= '0' && s[i] <= '9') {
        num = num * 10 + (s[i] - '0');
        i++;
        if (result > (INT_MAX - num) / 10) {
            return (sign == 1) ? INT_MAX : INT_MIN;
        }
        result = num;
    }
    return result * sign;
}