#include <stdlib.h> // For malloc, free, qsort

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int val;
    int row;
    int col;
} NodeInfo;

int compareNodes(const void* a, const void* b) {
    NodeInfo* nodeA = (NodeInfo*)a;
    NodeInfo* nodeB = (NodeInfo*)b;

    if (nodeA->col != nodeB->col) {
        return nodeA->col - nodeB->col;
    }
    if (nodeA->row != nodeB->row) {
        return nodeA->row - nodeB->row;
    }
    return nodeA->val - nodeB->val;
}

void dfs(struct TreeNode* node, int r, int c, NodeInfo* all_nodes, int* node_count) {
    if (node == NULL) {
        return;
    }

    // Store current node's information
    all_nodes[*node_count].val = node->val;
    all_nodes[*node_count].row = r;
    all_nodes[*node_count].col = c;
    (*node_count)++;

    // Recurse for left child: row+1, col-1
    dfs(node->left, r + 1, c - 1, all_nodes, node_count);
    // Recurse for right child: row+1, col+1
    dfs(node->right, r + 1, c + 1, all_nodes, node_count);
}

int** verticalTraversal(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Allocate memory for all node information. Max 1000 nodes as per constraints.
    NodeInfo* all_nodes = (NodeInfo*)malloc(1000 * sizeof(NodeInfo));
    int node_count = 0;

    // Perform DFS to collect all node data with their coordinates
    dfs(root, 0, 0, all_nodes, &node_count);

    // Sort the collected nodes based on the specified criteria
    qsort(all_nodes, node_count, sizeof(NodeInfo), compareNodes);

    // Determine the number of distinct columns
    int num_cols = 0;
    if (node_count > 0) {
        num_cols = 1; // At least one column if there are nodes
        for (int i = 1; i < node_count; ++i) {
            if (all_nodes[i].col != all_nodes[i-1].col) {
                num_cols++;
            }
        }
    }

    // Allocate memory for the result array and column sizes array
    *returnSize = num_cols;
    int** result = (int**)malloc(num_cols * sizeof(int*));
    *returnColumnSizes = (int*)malloc(num_cols * sizeof(int));

    // Group nodes by column and populate the result array
    int current_col_idx = 0;
    int i = 0;
    while (i < node_count) {
        int current_col_val = all_nodes[i].col;
        int count_in_col = 0;
        int j = i;
        // Count how many nodes are in the current column
        while (j < node_count && all_nodes[j].col == current_col_val) {
            count_in_col++;
            j++;
        }

        // Allocate memory for the current column's values
        result[current_col_idx] = (int*)malloc(count_in_col * sizeof(int));
        (*returnColumnSizes)[current_col_idx] = count_in_col;

        // Copy values into the current column's array
        for (int k = 0; k < count_in_col; ++k) {
            result[current_col_idx][k] = all_nodes[i + k].val;
        }

        // Move to the start of the next column
        i = j;
        current_col_idx++;
    }

    // Free the temporary storage used for all_nodes
    free(all_nodes);

    return result;
}