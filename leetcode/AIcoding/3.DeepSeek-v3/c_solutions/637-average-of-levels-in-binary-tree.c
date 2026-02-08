#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    double sum;
    int count;
} LevelData;

void dfs(struct TreeNode* node, int level, LevelData** levels, int* size) {
    if (!node) return;

    if (level >= *size) {
        *size = level + 1;
        *levels = realloc(*levels, *size * sizeof(LevelData));
        (*levels)[level].sum = 0;
        (*levels)[level].count = 0;
    }

    (*levels)[level].sum += node->val;
    (*levels)[level].count++;

    dfs(node->left, level + 1, levels, size);
    dfs(node->right, level + 1, levels, size);
}

double* averageOfLevels(struct TreeNode* root, int* returnSize) {
    LevelData* levels = NULL;
    int size = 0;

    dfs(root, 0, &levels, &size);

    double* result = malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) {
        result[i] = levels[i].sum / levels[i].count;
    }

    free(levels);
    *returnSize = size;
    return result;
}