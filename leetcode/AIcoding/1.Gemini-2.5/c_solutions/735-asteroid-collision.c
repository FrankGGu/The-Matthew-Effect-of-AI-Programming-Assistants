#include <stdlib.h> // Required for malloc and abs

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    // Use an array as a stack. The maximum size of the stack is asteroidsSize.
    int* stack = (int*)malloc(sizeof(int) * asteroidsSize);
    int stackTop = -1; // stackTop points to the top element, -1 if stack is empty.

    for (int i = 0; i < asteroidsSize; i++) {
        int currentAsteroid = asteroids[i];
        int destroyed = 0; // Flag to indicate if the currentAsteroid was destroyed

        // Collision logic: currentAsteroid is moving left (negative) AND
        // the asteroid at the top of the stack is moving right (positive).
        while (stackTop >= 0 && currentAsteroid < 0 && stack[stackTop] > 0) {
            // Compare absolute sizes
            if (abs(currentAsteroid) > stack[stackTop]) {
                // The asteroid on top of the stack is smaller, it explodes.
                stackTop--; // Pop from stack
                // currentAsteroid survives this collision and might collide with the next asteroid on stack.
            } else if (abs(currentAsteroid) == stack[stackTop]) {
                // Both asteroids are of the same size, both explode.
                stackTop--; // Pop from stack (top asteroid destroyed)
                destroyed = 1; // Current asteroid is also destroyed
                break; // Exit collision loop as currentAsteroid is destroyed
            } else { // abs(currentAsteroid) < stack[stackTop]
                // Current asteroid is smaller, it explodes.
                destroyed = 1; // Current asteroid is destroyed
                break; // Exit collision loop as currentAsteroid is destroyed
            }
        }

        // If the currentAsteroid was not destroyed in any collision, push it onto the stack.
        // This also covers cases where:
        // 1. stack is empty.
        // 2. currentAsteroid is positive (moving right).
        // 3. stackTop is negative (moving left), so they move in the same direction or away from each other.
        if (!destroyed) {
            stackTop++;
            stack[stackTop] = currentAsteroid;
        }
    }

    // All asteroids have been processed. The stack now contains the surviving asteroids.
    // Copy them to a new array of the correct size.
    *returnSize = stackTop + 1; // Number of elements in the final result

    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i <= stackTop; i++) {
        result[i] = stack[i];
    }

    free(stack); // Free the temporary stack memory

    return result;
}