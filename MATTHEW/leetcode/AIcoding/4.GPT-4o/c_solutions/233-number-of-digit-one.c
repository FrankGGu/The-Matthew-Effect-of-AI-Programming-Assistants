int countDigitOne(int n) {
    long long count = 0, factor = 1, previous = 0, current = 0;
    while (n >= factor) {
        current = (n / factor) % 10;
        previous = n / (factor * 10);

        if (current == 0) {
            count += previous * factor;
        } else if (current == 1) {
            count += previous * factor + (n % factor) + 1;
        } else {
            count += (previous + 1) * factor;
        }

        factor *= 10;
    }
    return count;
}