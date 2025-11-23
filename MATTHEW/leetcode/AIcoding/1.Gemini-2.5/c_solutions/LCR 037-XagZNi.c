#include <stdlib.h> // For malloc, free, and abs
#include <stdbool.h> // For bool type

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    // A stack to store surviving asteroids.
    // The maximum size of the stack can be asteroidsSize.
    int* stack = (int*)malloc(sizeof(int) * asteroidsSize);
    int stackTop = -1; // Index of the top element in the stack. -1 indicates an empty stack.

    for (int i = 0; i < asteroidsSize; i++) {
        int currentAsteroid = asteroids[i];
        bool currentAsteroidSurvived = true;

        // Collision logic:
        // A collision can only happen if the current asteroid is moving left (negative)
        // AND the asteroid at the top of the stack is moving right (positive).
        while (stackTop >= 0 && currentAsteroid < 0 && stack[stackTop] > 0) {
            // Collision is imminent
            if (abs(currentAsteroid) > stack[stackTop]) {
                // The asteroid on top of the stack explodes
                stackTop--;
                // currentAsteroidSurvived remains true, as the current asteroid continues
                // to move left and might collide with the new top of the stack.
            } else if (abs(currentAsteroid) == stack[stackTop]) {
                // Both asteroids explode
                stackTop--; // Pop the stack top
                currentAsteroidSurvived = false; // Current asteroid also explodes
                break; // No more collisions for the current asteroid
            } else { // abs(currentAsteroid) < stack[stackTop]
                // The current asteroid explodes
                currentAsteroidSurvived = false;
                break; // No more collisions for the current asteroid
            }
        }

        // If the current asteroid survived all potential collisions, push it onto the stack.
        // This includes cases where:
        // 1. The stack was empty.
        // 2. The current asteroid is moving right (currentAsteroid > 0).
        // 3. The top of the stack is moving left (stack[stackTop] < 0), so they move away.
        // 4. The current asteroid survived all collisions in the while loop.
        if (currentAsteroidSurvived) {
            stackTop++;
            stack[stackTop] = currentAsteroid;
        }
    }

    // Prepare the result array from the stack
    *returnSize = stackTop + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i <= stackTop; i++) {
        result[i] = stack[i];
    }

    // Free the temporary stack memory
    free(stack);

    return result;
}