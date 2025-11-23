int fillCups(int* cups, int cupsSize) {
    int max_val = 0;
    int sum = 0;

    int a = cups[0];
    int b = cups[1];
    int c = cups[2];

    sum = a + b + c;

    if (a > max_val) max_val = a;
    if (b > max_val) max_val = b;
    if (c > max_val) max_val = c;

    if (max_val > (sum - max_val)) {
        return max_val;
    } else {
        return (sum + 1) / 2;
    }
}