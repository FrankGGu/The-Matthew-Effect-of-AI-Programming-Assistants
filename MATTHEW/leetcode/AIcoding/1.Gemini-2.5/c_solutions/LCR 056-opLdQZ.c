#include <stdlib.h>
#include <stdbool.h>

void inorder_collect(struct TreeNode* root, int** nums_ptr, int* count_ptr, int* capacity_ptr) {
    if (root == NULL) {
        return;
    }

    inorder_collect(root->left, nums_ptr, count_ptr, capacity_ptr);

    if (*count_ptr == *capacity_ptr) {
        *capacity_ptr *= 2;
        *nums_ptr = (int*)realloc(*nums_ptr, (*capacity_ptr) * sizeof(int));
    }
    (*nums_ptr)[(*count_ptr)++] = root->val;

    inorder_collect(root->right, nums_ptr, count_ptr, capacity_ptr);
}

bool findTarget(struct TreeNode* root, int k) {
    int initial_capacity = 100;
    int* nums = (int*)malloc(initial_capacity * sizeof(int));
    int count = 0;
    int capacity = initial_capacity;

    inorder_collect(root, &nums, &count, &capacity);

    int left = 0;
    int right = count - 1;

    while (left < right) {
        int sum = nums[left] + nums[right];
        if (sum == k) {
            free(nums);
            return true;
        } else if (sum < k) {
            left++;
        } else {
            right--;
        }
    }

    free(nums);
    return false;
}