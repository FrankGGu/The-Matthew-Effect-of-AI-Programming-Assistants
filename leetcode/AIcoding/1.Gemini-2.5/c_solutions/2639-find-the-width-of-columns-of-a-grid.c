#include <stdlib.h> // For malloc
#include <math.h>   // For log10 (though manual calculation is often preferred for integer problems)
#include <string.h> // For strlen (if using sprintf)
#include <stdio.h>  // For sprintf (if using sprintf)

int* findColumnWidth(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int* result = (int*)malloc(cols * sizeof(int));
    *returnSize = cols;

    for (int j = 0; j < cols; ++j) {
        int max_width_for_col_j = 0;
        for (int i = 0; i < rows; ++i) {
            int num = grid[i][j];
            int current_width = 0;

            if (num == 0) {
                current_width = 1;
            } else {
                if (num < 0) {
                    current_width = 1; // For the '-' sign
                    num = -num;
                }
                while (num > 0) {
                    current_width++;
                    num /= 10;
                }
            }

            if (current_width > max_width_for_col_j) {
                max_width_for_col_j = current_width;
            }
        }
        result[j] = max_width_for_col_j;
    }

    return result;
}