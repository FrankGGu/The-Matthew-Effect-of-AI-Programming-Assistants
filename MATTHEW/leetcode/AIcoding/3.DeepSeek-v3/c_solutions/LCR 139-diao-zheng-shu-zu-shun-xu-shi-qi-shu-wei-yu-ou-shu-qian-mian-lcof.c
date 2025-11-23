/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* trainingPlan(int* actions, int actionsSize, int* returnSize) {
    int left = 0, right = actionsSize - 1;
    int* result = (int*)malloc(sizeof(int) * actionsSize);
    *returnSize = actionsSize;

    for (int i = 0; i < actionsSize; i++) {
        if (actions[i] % 2 == 1) {
            result[left++] = actions[i];
        } else {
            result[right--] = actions[i];
        }
    }

    return result;
}