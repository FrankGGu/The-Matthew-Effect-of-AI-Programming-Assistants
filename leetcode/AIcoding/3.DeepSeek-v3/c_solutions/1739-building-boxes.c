int minimumBoxes(int n) {
    int total = 0;
    int level = 0;
    int next = 0;

    while (total < n) {
        level++;
        next += level;
        if (total + next > n) {
            break;
        }
        total += next;
    }

    int base = next - level;
    int add = 0;
    while (total < n) {
        add++;
        total += add;
    }

    return base + add;
}