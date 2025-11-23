/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* pathInZigZagTree(int label, int* returnSize) {
    int level = 0;
    int temp = label;
    while (temp > 0) {
        level++;
        temp >>= 1;
    }

    *returnSize = level;
    int* path = (int*)malloc(level * sizeof(int));

    while (level > 0) {
        path[level - 1] = label;
        int levelStart = 1 << (level - 1);
        int levelEnd = (1 << level) - 1;
        label = levelStart + (levelEnd - label);
        label /= 2;
        level--;
    }

    return path;
}