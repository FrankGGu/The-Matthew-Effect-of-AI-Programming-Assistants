int countDigitOne(int n) {
    long long factor = 1;
    int count = 0;
    int current, before, after;

    while (n / factor > 0) {
        current = (n / factor) % 10;
        before = n / (factor * 10);
        after = n % factor;

        if (current == 0) {
            count += before * factor;
        } else if (current == 1) {
            count += before * factor + after + 1;
        } else {
            count += (before + 1) * factor;
        }

        factor *= 10;
    }

    return count;
}