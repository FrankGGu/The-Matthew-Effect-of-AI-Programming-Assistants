#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void find_nodes_at_distance(struct TreeNode* root, int k, int* result, int* result_size) {
    if (root == NULL) {
        return;
    }

    if (k == 0) {
        result[*result_size] = root->val;
        (*result_size)++;
        return;
    }

    find_nodes_at_distance(root->left, k - 1, result, result_size);
    find_nodes_at_distance(root->right, k - 1, result, result_size);
}

int distance_k_util(struct TreeNode* root, struct TreeNode* target, int k, int* result, int* result_size) {
    if (root == NULL) {
        return -1;
    }

    if (root == target) {
        find_nodes_at_distance(root, k, result, result_size);
        return 0;
    }

    int left_dist = distance_k_util(root->left, target, k, result, result_size);
    if (left_dist != -1) {
        if (left_dist + 1 == k) {
            result[*result_size] = root->val;
            (*result_size)++;
        } else {
            find_nodes_at_distance(root->right, k - left_dist - 2, result, result_size);
        }
        return left_dist + 1;
    }

    int right_dist = distance_k_util(root->right, target, k, result, result_size);
    if (right_dist != -1) {
        if (right_dist + 1 == k) {
            result[*result_size] = root->val;
            (*result_size)++;
        } else {
            find_nodes_at_distance(root->left, k - right_dist - 2, result, result_size);
        }
        return right_dist + 1;
    }

    return -1;
}

int* distanceK(struct TreeNode* root, struct TreeNode* target, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;
    distance_k_util(root, target, k, result, returnSize);
    return result;
}