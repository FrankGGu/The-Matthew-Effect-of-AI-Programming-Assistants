#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

bool* robot(char* commands, int** targets, int targetsSize, int* targetsColSize, int* returnSize) {
    int len = strlen(commands);

    // path_x[i] and path_y[i] store the robot's position after i commands in the first cycle.
    // path_x[0] = 0, path_y[0] = 0 (initial position)
    // path_x[len], path_y[len] is the position after one full cycle.
    int* path_x = (int*)malloc((len + 1) * sizeof(int));
    int* path_y = (int*)malloc((len + 1) * sizeof(int));

    int current_x = 0;
    int current_y = 0;

    path_x[0] = 0;
    path_y[0] = 0;

    for (int i = 0; i < len; ++i) {
        if (commands[i] == 'U') {
            current_y++;
        } else { // commands[i] == 'R'
            current_x++;
        }
        path_x[i+1] = current_x;
        path_y[i+1] = current_y;
    }

    int cycle_dx = path_x[len];
    int cycle_dy = path_y[len];

    bool* results = (bool*)malloc(targetsSize * sizeof(bool));
    *returnSize = targetsSize;

    for (int i = 0; i < targetsSize; ++i) {
        int tx = targets[i][0];
        int ty = targets[i][1];
        bool reachable = false;

        for (int p = 0; p <= len; ++p) { // Iterate through all points in the first cycle (including (0,0))
            int px = path_x[p];
            int py = path_y[p];

            // Target must be "ahead" or at the current path point relative to (0,0)
            if (tx < px || ty < py) {
                continue;
            }

            int rem_x = tx - px;
            int rem_y = ty - py;

            // Check x-component for divisibility or equality
            if (cycle_dx == 0) {
                if (rem_x != 0) { // If cycle_dx is 0, rem_x must be 0 for a match
                    continue;
                }
            } else { // cycle_dx > 0
                if (rem_x % cycle_dx != 0) { // rem_x must be a multiple of cycle_dx
                    continue;
                }
            }

            // Check y-component for divisibility or equality
            if (cycle_dy == 0) {
                if (rem_y != 0) { // If cycle_dy is 0, rem_y must be 0 for a match
                    continue;
                }
            } else { // cycle_dy > 0
                if (rem_y % cycle_dy != 0) { // rem_y must be a multiple of cycle_dy
                    continue;
                }
            }

            // At this point, both rem_x and rem_y are valid for their respective cycle_d values.
            // Now, we need to ensure the 'k' (number of cycles) is the same for both dimensions.
            if (cycle_dx > 0 && cycle_dy > 0) {
                // If both cycle_dx and cycle_dy are positive, the 'k' values must match.
                if (rem_x / cycle_dx == rem_y / cycle_dy) {
                    reachable = true;
                    break;
                }
            } else {
                // If either cycle_dx or cycle_dy (or both) are 0,
                // the conditions (rem_x=0 or rem_x%cycle_dx=0) and (rem_y=0 or rem_y%cycle_dy=0)
                // already imply reachability if we've reached this point.
                // For example, if cycle_dx=0, rem_x must be 0. The x-coordinate is fixed to px.
                // The k is determined solely by the y-coordinate (if cycle_dy > 0).
                // Or if both are 0, then tx=px, ty=py (k=0).
                reachable = true;
                break;
            }
        }
        results[i] = reachable;
    }

    free(path_x);
    free(path_y);

    return results;
}