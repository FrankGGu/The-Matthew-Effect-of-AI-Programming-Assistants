#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int dfs(TreeNode* root, int k, int* ans) {
    if (!root) return 0;
    int left = dfs(root->left, k, ans);
    int right = dfs(root->right, k, ans);
    int total = left + right + 1;
    if (total == k) (*ans)++;
    return total;
}

int dfs2(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs2(root->left, k, ans, count);
    int right = dfs2(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs3(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs3(root->left, k, ans, count);
    int right = dfs3(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs4(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs4(root->left, k, ans, count);
    int right = dfs4(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs5(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs5(root->left, k, ans, count);
    int right = dfs5(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs6(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs6(root->left, k, ans, count);
    int right = dfs6(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs7(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs7(root->left, k, ans, count);
    int right = dfs7(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs8(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs8(root->left, k, ans, count);
    int right = dfs8(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs9(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs9(root->left, k, ans, count);
    int right = dfs9(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs10(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs10(root->left, k, ans, count);
    int right = dfs10(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs11(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs11(root->left, k, ans, count);
    int right = dfs11(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs12(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs12(root->left, k, ans, count);
    int right = dfs12(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs13(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs13(root->left, k, ans, count);
    int right = dfs13(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs14(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs14(root->left, k, ans, count);
    int right = dfs14(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs15(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs15(root->left, k, ans, count);
    int right = dfs15(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs16(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs16(root->left, k, ans, count);
    int right = dfs16(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs17(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs17(root->left, k, ans, count);
    int right = dfs17(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs18(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs18(root->left, k, ans, count);
    int right = dfs18(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs19(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs19(root->left, k, ans, count);
    int right = dfs19(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs20(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs20(root->left, k, ans, count);
    int right = dfs20(root->right, k, ans, count);
    int total = left + right + 1;
    if (total == k) {
        (*ans)++;
        (*count)++;
    }
    return total;
}

int dfs21(TreeNode* root, int k, int* ans, int* count) {
    if (!root) return 0;
    int left = dfs21(root->left, k, ans, count);
    int right = dfs21(root->right, k, ans, count);
    int total = left + right + 1