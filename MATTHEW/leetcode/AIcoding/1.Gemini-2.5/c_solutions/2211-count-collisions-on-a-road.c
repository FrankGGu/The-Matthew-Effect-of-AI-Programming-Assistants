#include <string.h>

int countCollisions(char * directions) {
    int total_collisions = 0;
    int r_count = 0; // Number of 'R' cars currently moving right and haven't collided yet
    int has_stationary_car = 0; // 1 if an 'S' car or a car that became stationary has been encountered

    int n = strlen(directions);

    for (int i = 0; i < n; i++) {
        char c = directions[i];

        if (c == 'R') {
            r_count++;
        } else if (c == 'S') {
            // An 'S' car is encountered.
            // All 'R' cars to its left that are currently moving will collide.
            // Each 'R' car contributes 1 collision.
            total_collisions += r_count;
            r_count = 0; // These 'R' cars are now stationary
            has_stationary_car = 1; // We now have a stationary point on the road
        } else { // c == 'L'
            if (r_count > 0) {
                // An 'L' car meets an 'R' car (or a chain of 'R' cars).
                // The 'L' car collides with the first 'R' car it meets.
                // All 'r_count' 'R' cars will eventually become stationary.
                // The 'L' car itself also becomes stationary.
                // This scenario results in (r_count + 1) collisions.
                total_collisions += r_count + 1;
                r_count = 0; // All 'R' cars are now stopped
                has_stationary_car = 1; // We now have a stationary point
            } else if (has_stationary_car) {
                // An 'L' car meets an already stationary car (either an original 'S' or a stopped 'R'/'L').
                // This 'L' car collides.
                total_collisions += 1;
            }
            // If r_count is 0 and has_stationary_car is 0, this 'L' car moves left freely
            // and does not collide with anything to its left.
        }
    }

    return total_collisions;
}