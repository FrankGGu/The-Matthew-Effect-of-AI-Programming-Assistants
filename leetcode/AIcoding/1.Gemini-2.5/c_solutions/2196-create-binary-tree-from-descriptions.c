#include <stdlib.h> // For malloc
#include <stdbool.h> // For bool

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_NODE_VAL 100001

static struct TreeNode* node_map[MAX_NODE_VAL];
static bool is_child[MAX_NODE_VAL];

struct TreeNode* createBinaryTree(int** descriptions, int descriptionsSize, int* descriptionsColSize) {
    // Determine the maximum node value present in the current test case.
    // This allows us to efficiently clear only the relevant parts of the static arrays.
    int max_val_in_current_test = 0;
    for (int i = 0; i < descriptionsSize; i++) {
        if (descriptions[i][0] > max_val_in_current_test) {
            max_val_in_current_test = descriptions[i][0];
        }
        if (descriptions[i][1] > max_val_in_current_test) {
            max_val_in_current_test = descriptions[i][1];
        }
    }

    // Reset the relevant parts of the static arrays for the current test case.
    // This is crucial because static variables retain their values across function calls.
    for (int i = 1; i <= max_val_in_current_test; i++) {
        node_map[i] = NULL;
        is_child[i] = false;
    }

    // Iterate through descriptions to build the tree structure.
    for (int i = 0; i < descriptionsSize; i++) {
        int parent_val = descriptions[i][0];
        int child_val = descriptions[i][1];
        int is_left = descriptions[i][2];

        // Ensure the parent node exists in our map. Create it if it doesn't.
        if (node_map[parent_val] == NULL) {
            node_map[parent_val] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            node_map[parent_val]->val = parent_val;
            node_map[parent_val]->left = NULL;
            node_map[parent_val]->right = NULL;
        }
        struct TreeNode* parent_node = node_map[parent_val];

        // Ensure the child node exists in our map. Create it if it doesn't.
        if (node_map[child_val] == NULL) {
            node_map[child_val] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            node_map[child_val]->val = child_val;
            node_map[child_val]->left = NULL;
            node_map[child_val]->right = NULL;
        }
        struct TreeNode* child_node = node_map[child_val];

        // Link the child node to its parent based on 'is_left'.
        if (is_left == 1) {
            parent_node->left = child_node;
        } else {
            parent_node->right = child_node;
        }

        // Mark the child node as having a parent.
        is_child[child_val] = true;
    }

    // Find the root node.
    // The root is the only node that exists in the tree but was never a child of any other node.
    struct TreeNode* root = NULL;
    for (int i = 1; i <= max_val_in_current_test; i++) {
        if (node_map[i] != NULL && !is_child[i]) {
            root = node_map[i];
            break; // There is guaranteed to be exactly one root.
        }
    }

    return root;
}