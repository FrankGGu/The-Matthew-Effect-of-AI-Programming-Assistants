int* pathInZigZagTree(int label, int* returnSize) {
    int* path = (int*)malloc(32 * sizeof(int));
    int index = 0;

    while (label > 0) {
        path[index++] = label;
        label /= 2;
    }

    if (index % 2 == 0) {
        for (int i = 0; i < index; i++) {
            path[i] = (1 << (index - i - 1)) - 1 - (path[i] - (1 << (index - 1)));
        }
    }

    *returnSize = index;
    for (int i = 0; i < index / 2; i++) {
        int temp = path[i];
        path[i] = path[index - i - 1];
        path[index - i - 1] = temp;
    }

    return path;
}