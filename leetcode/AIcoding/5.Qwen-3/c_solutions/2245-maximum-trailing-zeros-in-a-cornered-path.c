#include <stdio.h>
#include <stdlib.h>

int maxTrailingZeros(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** prefix = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        prefix[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int val = grid[i][j];
            int cnt5 = 0, cnt2 = 0;
            while (val % 5 == 0) {
                cnt5++;
                val /= 5;
            }
            while (val % 2 == 0) {
                cnt2++;
                val /= 2;
            }
            prefix[i][j] = (cnt2 << 16) | cnt5;
        }
    }

    int max_trail = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int up = 0, left = 0, down = 0, right = 0;

            int x = i, y = j;
            while (x >= 0) {
                int val = prefix[x][y];
                up += (val & 0xFFFF);
                x--;
            }

            x = i;
            y = j;
            while (y >= 0) {
                int val = prefix[x][y];
                left += (val & 0xFFFF);
                y--;
            }

            x = i;
            y = j;
            while (x < rows) {
                int val = prefix[x][y];
                down += (val & 0xFFFF);
                x++;
            }

            x = i;
            y = j;
            while (y < cols) {
                int val = prefix[x][y];
                right += (val & 0xFFFF);
                y++;
            }

            int t = (prefix[i][j] & 0xFFFF);
            int temp = 0;
            if (up > 0) temp = (up - (prefix[i][j] & 0xFFFF)) + t;
            else temp = t;
            max_trail = (temp > max_trail) ? temp : max_trail;

            if (left > 0) temp = (left - (prefix[i][j] & 0xFFFF)) + t;
            else temp = t;
            max_trail = (temp > max_trail) ? temp : max_trail;

            if (down > 0) temp = (down - (prefix[i][j] & 0xFFFF)) + t;
            else temp = t;
            max_trail = (temp > max_trail) ? temp : max_trail;

            if (right > 0) temp = (right - (prefix[i][j] & 0xFFFF)) + t;
            else temp = t;
            max_trail = (temp > max_trail) ? temp : max_trail;
        }
    }

    for (int i = 0; i < rows; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return max_trail;
}