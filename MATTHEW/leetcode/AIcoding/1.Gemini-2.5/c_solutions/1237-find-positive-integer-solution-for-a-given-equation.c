#include <stdlib.h>

int** findSolution(CustomFunction* customfunction, int z, int* returnSize, int** returnColumnSizes) {
    // The maximum number of solutions is z (e.g., if f(x,y) = x+y and z=1000,
    // solutions (1,999), (2,998), ..., (999,1) are 999 solutions).
    // Allocating space for 'z' solutions is sufficient.
    int** result = (int**)malloc(sizeof(int*) * z);
    int count = 0;

    int x = 1;
    // The maximum possible value for x or y is 1000, as z <= 1000.
    // For example, if f(x,y) = x*y and z=1000, then (1,1000) is a solution.
    // So y should start from 1000 (the maximum possible value for y).
    int y = 1000; 

    // Use a two-pointer approach.
    // x starts from 1 and increases.
    // y starts from 1000 and decreases.
    // This works because f(x,y) is monotonically increasing in both x and y.
    while (x <= 1000 && y >= 1) {
        int current_val = customfunction->f(x, y);

        if (current_val == z) {
            result[count] = (int*)malloc(sizeof(int) * 2);
            result[count][0] = x;
            result[count][1] = y;
            count++;
            x++; // Move to find next solution by increasing x
            y--; // Move to find next solution by decreasing y
        } else if (current_val < z) {
            x++; // If current_val is too small, increase x to get a larger f(x,y)
        } else { // current_val > z
            y--; // If current_val is too large, decrease y to get a smaller f(x,y)
        }
    }

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}