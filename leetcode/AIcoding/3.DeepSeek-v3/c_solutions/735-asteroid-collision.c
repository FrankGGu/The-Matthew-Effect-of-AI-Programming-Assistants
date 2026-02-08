/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    int* stack = (int*)malloc(asteroidsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        int asteroid = asteroids[i];

        if (top == -1 || asteroid > 0 || stack[top] < 0) {
            stack[++top] = asteroid;
        } else {
            while (top >= 0 && stack[top] > 0 && stack[top] < -asteroid) {
                top--;
            }

            if (top >= 0 && stack[top] > 0 && stack[top] == -asteroid) {
                top--;
            } else if (top == -1 || stack[top] < 0) {
                stack[++top] = asteroid;
            }
        }
    }

    *returnSize = top + 1;
    return stack;
}