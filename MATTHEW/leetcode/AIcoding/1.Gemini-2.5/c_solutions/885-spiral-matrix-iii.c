int** spiralMatrixIII(int R, int C, int rStart, int cStart, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(R * C * sizeof(int*));
    *returnColumnSizes = (int*)malloc(R * C * sizeof(int));
    *returnSize = 0;

    // Directions: Right, Down, Left, Up
    int dr[] = {0, 1, 0, -1};
    int dc[] = {1, 0, -1, 0};

    int r = rStart;
    int c = cStart;
    int dir = 0; // Current direction index (0:Right, 1:Down, 2:Left, 3:Up)
    int len = 1; // Current step length for the direction
    int steps_for_current_len = 0; // How many directions have used the current 'len'

    // Add the starting point if it's within bounds
    if (r >= 0 && r < R && c >= 0 && c < C) {
        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = r;
        result[*returnSize][1] = c;
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
    }

    // Continue until R*C points are collected
    while (*returnSize < R * C) {
        // Move 'len' steps in the current direction
        for (int i = 0; i < len; ++i) {
            r += dr[dir];
            c += dc[dir];

            // If the new position is within bounds, add it to the result
            if (r >= 0 && r < R && c >= 0 && c < C) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = r;
                result[*returnSize][1] = c;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }

            // If all R*C points are collected, break early
            if (*returnSize == R * C) {
                break;
            }
        }

        // If all R*C points are collected, break the outer loop as well
        if (*returnSize == R * C) {
            break;
        }

        // Change direction (clockwise turn)
        dir = (dir + 1) % 4;
        steps_for_current_len++;

        // After two directions (e.g., Right then Down, or Left then Up), increment the step length
        if (steps_for_current_len == 2) {
            len++;
            steps_for_current_len = 0; // Reset counter for the new length
        }
    }

    return result;
}