bool hasAlternatingBits(int n) {
    long long num = n;
    long long temp = (num >> 1) ^ num;
    return (temp & (temp + 1)) == 0;
}