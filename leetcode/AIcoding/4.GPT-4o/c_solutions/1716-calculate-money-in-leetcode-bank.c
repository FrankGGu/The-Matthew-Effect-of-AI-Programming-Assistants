int totalMoney(int n) {
    int weeks = n / 7;
    int days = n % 7;
    return (weeks * (28 + weeks * 7) / 2) + (days * (days + 1) / 2 + weeks * days);
}