int longestString(int x, int y, int z) {
    int min_xy = (x < y) ? x : y;
    int count_xy_pairs;

    if (x == y) {
        count_xy_pairs = 2 * min_xy;
    } else {
        count_xy_pairs = 2 * min_xy + 1;
    }

    return (count_xy_pairs + z) * 2;
}