/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    int* stack = (int*)malloc(asteroidsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        int asteroid = asteroids[i];
        bool exploded = false;

        while (top >= 0 && stack[top] > 0 && asteroid < 0) {
            if (stack[top] < -asteroid) {
                top--;
                continue;
            } else if (stack[top] == -asteroid) {
                top--;
                exploded = true;
                break;
            } else {
                exploded = true;
                break;
            }
        }

        if (!exploded) {
            stack[++top] = asteroid;
        }
    }

    *returnSize = top + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = stack[i];
    }
    free(stack);
    return result;
}