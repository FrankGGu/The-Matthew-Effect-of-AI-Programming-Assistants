int* countOfPairs(int n, int x, int y, int* returnSize) {
    *returnSize = n;
    int* ans = (int*)calloc(n, sizeof(int));

    if (x > y) {
        int temp = x;
        x = y;
        y = temp;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int dist = j - i;

            int dist_x_y = abs(x - i) + 1 + abs(y - j);
            int dist_y_x = abs(y - i) + 1 + abs(x - j);

            int current_min_dist = dist;

            if (i <= x && j >= y) { // Path goes through the cycle
                current_min_dist = fmin(current_min_dist, abs(x - i) + 1 + abs(y - j));
            } else if (i <= x && j >= x && j < y) { // i before x, j between x and y
                current_min_dist = fmin(current_min_dist, abs(x - i) + 1 + abs(y - j));
                current_min_dist = fmin(current_min_dist, abs(y - i) + 1 + abs(x - j));
            } else if (i > x && i < y && j >= y) { // i between x and y, j after y
                current_min_dist = fmin(current_min_dist, abs(x - i) + 1 + abs(y - j));
                current_min_dist = fmin(current_min_dist, abs(y - i) + 1 + abs(x - j));
            } else if (i > x && j < y) { // both i and j between x and y
                current_min_dist = fmin(current_min_dist, abs(x - i) + 1 + abs(y - j));
                current_min_dist = fmin(current_min_dist, abs(y - i) + 1 + abs(x - j));
            }

            ans[current_min_dist - 1]++;
        }
    }

    return ans;
}