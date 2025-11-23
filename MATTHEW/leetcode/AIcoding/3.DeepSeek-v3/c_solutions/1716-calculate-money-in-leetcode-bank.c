int totalMoney(int n) {
    int weeks = n / 7;
    int days = n % 7;
    int total = 0;

    total += weeks * 28;
    total += 7 * (weeks * (weeks - 1)) / 2;

    total += days * (weeks + 1);
    total += (days * (days - 1)) / 2;

    return total;
}