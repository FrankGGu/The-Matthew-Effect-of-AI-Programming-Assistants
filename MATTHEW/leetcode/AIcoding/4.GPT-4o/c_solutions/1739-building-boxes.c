int minimumBoxes(int n) {
    int total = 0, i = 0, boxes = 0;
    while (total + (i + 1) * (i + 2) / 2 <= n) {
        i++;
        total += i * (i + 1) / 2;
        boxes += i;
    }
    return boxes + (n - total);
}