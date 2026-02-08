#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxTrailingZeros(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int row_two[rows][cols];
    int row_five[rows][cols];
    int col_two[rows][cols];
    int col_five[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int num = grid[i][j];
            int two_count = 0;
            int five_count = 0;
            while (num > 0 && num % 2 == 0) {
                two_count++;
                num /= 2;
            }
            while (num > 0 && num % 5 == 0) {
                five_count++;
                num /= 5;
            }
            row_two[i][j] = two_count;
            row_five[i][j] = five_count;
            col_two[i][j] = two_count;
            col_five[i][j] = five_count;
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            row_two[i][j] += row_two[i][j - 1];
            row_five[i][j] += row_five[i][j - 1];
        }
    }

    for (int j = 0; j < cols; j++) {
        for (int i = 1; i < rows; i++) {
            col_two[i][j] += col_two[i - 1][j];
            col_five[i][j] += col_five[i - 1][j];
        }
    }

    int max_zeros = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int up_two = col_two[i][j];
            int up_five = col_five[i][j];
            int left_two = row_two[i][j];
            int left_five = row_five[i][j];
            int down_two = col_two[rows - 1][j] - col_two[i][j];
            int down_five = col_five[rows - 1][j] - col_five[i][j];
            int right_two = row_two[i][cols - 1] - row_two[i][j];
            int right_five = row_five[i][cols - 1] - row_five[i][j];

            int corner1_two = up_two + left_two - row_two[i][j];
            int corner1_five = up_five + left_five - row_five[i][j];
            max_zeros = fmax(max_zeros, fmin(corner1_two, corner1_five));

            int corner2_two = up_two + right_two - row_two[i][j];
            int corner2_five = up_five + right_five - row_five[i][j];
            max_zeros = fmax(max_zeros, fmin(corner2_two, corner2_five));

            int corner3_two = down_two + left_two - row_two[i][j];
            int corner3_five = down_five + left_five - row_five[i][j];
            max_zeros = fmax(max_zeros, fmin(corner3_two, corner3_five));

            int corner4_two = down_two + right_two - row_two[i][j];
            int corner4_five = down_five + right_five - row_five[i][j];
            max_zeros = fmax(max_zeros, fmin(corner4_two, corner4_five));
        }
    }

    return max_zeros;
}