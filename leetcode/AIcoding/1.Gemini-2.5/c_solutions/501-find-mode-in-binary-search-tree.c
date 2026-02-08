#include <stdlib.h> // For malloc, realloc

static int g_current_val_p1;
static int g_current_count_p1;
static int g_max_count_p1;

static int g_current_val_p2;
static int g_current_count_p2;
static int* g_result_modes;
static int g_result_size;
static int g_result_capacity;
static int g_target_max_count;

static void inorder_traverse_pass1(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }

    inorder_traverse_pass1(root->left);

    if (g_current_count_p1 == 0) { // First node encountered in traversal
        g_current_val_p1 = root->val;
        g_current_count_p1 = 1;
    } else if (g_current_val_p1 == root->val) {
        g_current_count_p1++;
    } else {
        g_current_val_p1 = root->val;
        g_current_count_p1 = 1;
    }

    if (g_current_count_p1 > g_max_count_p1) {
        g_max_count_p1 = g_current_count_p1;
    }

    inorder_traverse_pass1(root->right);
}

static void add_mode(int val) {
    if (g_result_size == g_result_capacity) {
        g_result_capacity = g_result_capacity == 0 ? 1 : g_result_capacity * 2;
        g_result_modes = (int*)realloc(g_result_modes, g_result_capacity * sizeof(int));
    }
    g_result_modes[g_result_size++] = val;
}

static void inorder_traverse_pass2(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }

    inorder_traverse_pass2(root->left);

    if (g_current_count_p2 == 0) { // First node encountered in traversal
        g_current_val_p2 = root->val;
        g_current_count_p2 = 1;
    } else if (g_current_val_p2 == root->val) {
        g_current_count_p2++;
    } else {
        g_current_val_p2 = root->val;
        g_current_count_p2 = 1;
    }

    if (g_current_count_p2 == g_target_max_count) {
        add_mode(g_current_val_p2);
    }

    inorder_traverse_pass2(root->right);
}

int* findMode(struct TreeNode* root, int* returnSize) {
    // Reset global variables for pass 1
    g_current_val_p1 = 0; 
    g_current_count_p1 = 0;
    g_max_count_p1 = 0;

    // Perform pass 1 to find max_count
    inorder_traverse_pass1(root);

    // Handle empty tree case
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    // Reset global variables for pass 2
    g_current_val_p2 = 0; 
    g_current_count_p2 = 0;
    g_result_modes = NULL; // Initialize to NULL before first realloc
    g_result_size = 0;
    g_result_capacity = 0;
    g_target_max_count = g_max_count_p1;

    // Perform pass 2 to collect modes
    inorder_traverse_pass2(root);

    *returnSize = g_result_size;
    return g_result_modes;
}