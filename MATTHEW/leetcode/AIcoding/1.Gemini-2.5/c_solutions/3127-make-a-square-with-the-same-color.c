#include <stdbool.h>

bool makesquare(char grid[3][3]) {
    // Check top-left 2x2 square
    if (grid[0][0] == grid[0][1] &&
        grid[0][0] == grid[1][0] &&
        grid[0][0] == grid[1][1]) {
        return true;
    }

    // Check top-right 2x2 square
    if (grid[0][1] == grid[0][2] &&
        grid[0][1] == grid[1][1] &&
        grid[0][1] == grid[1][2]) {
        return true;
    }

    // Check bottom-left 2x2 square
    if (grid[1][0] == grid[1][1] &&
        grid[1][0] == grid[2][0] &&
        grid[1][0] == grid[2][1]) {
        return true;
    }

    // Check bottom-right 2x2 square
    if (grid[1][1] == grid[1][2] &&
        grid[1][1] == grid[2][1] &&
        grid[1][1] == grid[2][2]) {
        return true;
    }

    return false;
}