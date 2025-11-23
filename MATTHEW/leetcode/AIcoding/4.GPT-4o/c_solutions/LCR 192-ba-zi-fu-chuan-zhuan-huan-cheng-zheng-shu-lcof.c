int myAtoi(char * s) {
    long long int num = 0;
    int sign = 1, i = 0;

    while (s[i] == ' ') i++;

    if (s[i] == '-' || s[i] == '+') {
        sign = (s[i] == '-') ? -1 : 1;
        i++;
    }

    while (s[i] >= '0' && s[i] <= '9') {
        num = num * 10 + (s[i] - '0');
        if (num * sign >= INT_MAX) return INT_MAX;
        if (num * sign <= INT_MIN) return INT_MIN;
        i++;
    }

    return (int)(num * sign);
}