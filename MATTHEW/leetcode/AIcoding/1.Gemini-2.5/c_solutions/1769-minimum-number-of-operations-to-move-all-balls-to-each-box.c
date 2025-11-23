#include <stdlib.h>
#include <string.h>

int* minOperations(char* boxes, int* returnSize) {
    int n = strlen(boxes);
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    int left_balls = 0;
    int right_balls = 0;
    long long current_left_ops = 0;  // Sum of distances of balls to the left of current_box
    long long current_right_ops = 0; // Sum of distances of balls to the right of current_box

    // Calculate initial state for result[0]
    // All balls are considered to the right of box 0 initially
    for (int j = 0; j < n; j++) {
        if (boxes[j] == '1') {
            right_balls++;
            current_right_ops += j; // Distance from j to 0 is j
        }
    }
    result[0] = (int)current_right_ops;

    // Adjust counts for box 0 itself, as it moves from 'right' to 'left' group for subsequent calculations
    if (boxes[0] == '1') {
        left_balls++;
        right_balls--;
        // current_left_ops remains 0 because distance from 0 to 0 is 0
        // current_right_ops already correctly reflects sum of distances to 0 for balls at j > 0
    }

    // Iterate for i from 1 to n-1
    for (int i = 1; i < n; i++) {
        // When moving from box (i-1) to box i:
        // All 'left_balls' move 1 step further from i-1 to i. So their total ops increase by left_balls.
        current_left_ops += left_balls;
        // All 'right_balls' move 1 step closer from i-1 to i. So their total ops decrease by right_balls.
        current_right_ops -= right_balls;

        result[i] = (int)(current_left_ops + current_right_ops);

        // Update counts for the current box i, as it moves from 'right' to 'left' group
        if (boxes[i] == '1') {
            left_balls++;
            right_balls--;
        }
    }

    return result;
}