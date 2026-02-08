int orchestraLayout(int num, int xPos, int yPos) {
    long long n = num;
    long long x = xPos;
    long long y = yPos;

    long long layer = x < y ? x : y;
    layer = layer < n - 1 - x ? layer : n - 1 - x;
    layer = layer < n - 1 - y ? layer : n - 1 - y;

    long long total = (4 * n - 4) * layer - 4 * (layer - 1) * layer;

    long long start = layer;
    long long end = n - layer - 1;

    if (x == start) {
        total += y - start + 1;
    } else if (y == end) {
        total += (end - start) + (x - start) + 1;
    } else if (x == end) {
        total += 2 * (end - start) + (end - y) + 1;
    } else {
        total += 3 * (end - start) + (end - x) + 1;
    }

    return (total - 1) % 9 + 1;
}