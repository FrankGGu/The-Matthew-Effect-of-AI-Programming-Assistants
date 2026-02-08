#include <stdlib.h>

int get_level(int n) {
    int level = 0;
    while (n > 0) {
        n /= 2;
        level++;
    }
    return level;
}

int* pathInZigzagTree(int label, int* returnSize) {
    int path_len = get_level(label);

    int* path = (int*)malloc(path_len * sizeof(int));
    *returnSize = path_len;

    int path_idx = path_len - 1;
    path[path_idx--] = label;

    while (label > 1) {
        int level_of_label = get_level(label);

        int min_val_curr_level = 1 << (level_of_label - 1);
        int max_val_curr_level = (1 << level_of_label) - 1;

        if (level_of_label % 2 == 0) {
            int standard_pos_label = min_val_curr_level + (max_val_curr_level - label);
            int parent_standard = standard_pos_label / 2;
            label = parent_standard;
        } else {
            label = label / 2;
        }
        path[path_idx--] = label;
    }

    return path;
}