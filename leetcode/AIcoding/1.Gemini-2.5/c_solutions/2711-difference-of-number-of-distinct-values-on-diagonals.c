#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

int** differenceOfDistinctValues(int** grid, int gridRowSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int numCols = gridColSize[0];

    int** result = (int**)malloc(gridRowSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(gridRowSize * sizeof(int));
    *returnSize = gridRowSize;

    for (int i = 0; i < gridRowSize; i++) {
        result[i] = (int*)malloc(numCols * sizeof(int));
        (*returnColumnSizes)[i] = numCols;
    }

    for (int r = 0; r < gridRowSize; r++) {
        for (int c = 0; c < numCols; c++) {
            int distinct_top_left_count = 0;
            bool seen_tl[101] = {false}; 

            int curr_r_tl = r - 1;
            int curr_c_tl = c - 1;
            while (curr_r_tl >= 0 && curr_c_tl >= 0) {
                int val = grid[curr_r_tl][curr_c_tl];
                if (!seen_tl[val]) {
                    seen_tl[val] = true;
                    distinct_top_left_count++;
                }
                curr_r_tl--;
                curr_c_tl--;
            }

            int distinct_bottom_right_count = 0;
            bool seen_br[101] = {false}; 

            int curr_r_br = r + 1;
            int curr_c_br = c + 1;
            while (curr_r_br < gridRowSize && curr_c_br < numCols) {
                int val = grid[curr_r_br][curr_c_br];
                if (!seen_br[val]) {
                    seen_br[val] = true;
                    distinct_bottom_right_count++;
                }
                curr_r_br++;
                curr_c_br++;
            }

            result[r][c] = abs(distinct_top_left_count - distinct_bottom_right_count);
        }
    }

    return result;
}