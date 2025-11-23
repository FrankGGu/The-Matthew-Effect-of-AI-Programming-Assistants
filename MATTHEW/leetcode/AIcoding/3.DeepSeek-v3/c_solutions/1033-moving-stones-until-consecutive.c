int* numMovesStones(int a, int b, int c, int* returnSize) {
    int *res = (int *)malloc(2 * sizeof(int));
    *returnSize = 2;

    int x = a, y = b, z = c;
    if (x > y) { int temp = x; x = y; y = temp; }
    if (x > z) { int temp = x; x = z; z = temp; }
    if (y > z) { int temp = y; y = z; z = temp; }

    int min_moves, max_moves;

    if (z - x == 2) {
        min_moves = 0;
    } else if (y - x == 1 || z - y == 1 || y - x == 2 || z - y == 2) {
        min_moves = 1;
    } else {
        min_moves = 2;
    }

    max_moves = (z - x - 2);

    res[0] = min_moves;
    res[1] = max_moves;
    return res;
}