int* trainingPlan(int* actions, int actionsSize, int* returnSize) {
    int xorResult = 0;
    for (int i = 0; i < actionsSize; i++) {
        xorResult ^= actions[i];
    }

    int mask = 1;
    while ((xorResult & mask) == 0) {
        mask <<= 1;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;

    for (int i = 0; i < actionsSize; i++) {
        if ((actions[i] & mask) == 0) {
            result[0] ^= actions[i];
        } else {
            result[1] ^= actions[i];
        }
    }

    *returnSize = 2;
    return result;
}