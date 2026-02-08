int maxBuilding(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize) {
    if (restrictionsSize == 0) return n - 1;

    int m = restrictionsSize;
    int** r = malloc((m + 2) * sizeof(int*));
    for (int i = 0; i < m; i++) {
        r[i] = malloc(2 * sizeof(int));
        r[i][0] = restrictions[i][0];
        r[i][1] = restrictions[i][1];
    }

    r[m] = malloc(2 * sizeof(int));
    r[m][0] = 1;
    r[m][1] = 0;

    r[m + 1] = malloc(2 * sizeof(int));
    r[m + 1][0] = n;
    r[m + 1][1] = n - 1;

    m += 2;

    for (int i = 0; i < m; i++) {
        for (int j = i + 1; j < m; j++) {
            if (r[i][0] > r[j][0]) {
                int* temp = r[i];
                r[i] = r[j];
                r[j] = temp;
            }
        }
    }

    for (int i = 1; i < m; i++) {
        r[i][1] = (r[i][1] < r[i - 1][1] + (r[i][0] - r[i - 1][0])) ? r[i][1] : r[i - 1][1] + (r[i][0] - r[i - 1][0]);
    }

    for (int i = m - 2; i >= 0; i--) {
        r[i][1] = (r[i][1] < r[i + 1][1] + (r[i + 1][0] - r[i][0])) ? r[i][1] : r[i + 1][1] + (r[i + 1][0] - r[i][0]);
    }

    int ans = 0;
    for (int i = 0; i < m - 1; i++) {
        int left = r[i][0], right = r[i + 1][0];
        int left_h = r[i][1], right_h = r[i + 1][1];
        int h_diff = abs(left_h - right_h);
        int dist = right - left - h_diff;
        ans = (ans > (left_h > right_h ? right_h : left_h) + (dist + 1) / 2) ? ans : ((left_h > right_h ? right_h : left_h) + (dist + 1) / 2);
    }

    for (int i = 0; i < m; i++) {
        free(r[i]);
    }
    free(r);

    return ans;
}