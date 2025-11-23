#include <stdlib.h>
#include <string.h> // For memset

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* parent_map[501];
struct TreeNode* val_to_node_map[501];

void buildMaps(struct TreeNode* node, struct TreeNode* parent) {
    if (node == NULL) {
        return;
    }
    parent_map[node->val] = parent;
    val_to_node_map[node->val] = node;
    buildMaps(node->left, node);
    buildMaps(node->right, node);
}

struct QueueNode {
    struct TreeNode* node;
    int dist;
};

int* distanceK(struct TreeNode* root, struct TreeNode* target, int k, int* returnSize) {
    // Reset global maps for each test case to ensure no leftover data from previous calls.
    // Assuming max node value is 500.
    memset(parent_map, 0, sizeof(parent_map));
    memset(val_to_node_map, 0, sizeof(val_to_node_map));

    // Build parent and node lookup maps by traversing the tree.
    buildMaps(root, NULL);

    // BFS setup:
    // Queue to store nodes and their distances from the target.
    // Max 500 nodes in the tree, so a queue of size 501 is sufficient.
    struct QueueNode queue[501];
    int head = 0;
    int tail = 0;

    // Visited array to keep track of nodes already processed, preventing cycles and redundant work.
    // Using node values as indices, max 500.
    int visited[501];
    memset(visited, 0, sizeof(visited)); // Initialize all to 0 (not visited).

    // Array to store the final results. Max 500 nodes, so 500 elements is sufficient.
    int* result_arr = (int*)malloc(sizeof(int) * 500);
    int result_count = 0;

    // Enqueue the target node with distance 0.
    queue[tail].node = target;
    queue[tail].dist = 0;
    tail++;
    visited[target->val] = 1;

    // Perform Breadth-First Search.
    while (head < tail) {
        struct TreeNode* curr_node = queue[head].node;
        int curr_dist = queue[head].dist;
        head++;

        // If the current node is at distance K, add its value to the result.
        if (curr_dist == k) {
            result_arr[result_count++] = curr_node->val;
            // No need to explore further from this node, as its neighbors would be at distance k+1.
            continue; 
        }

        // Optimization: If current distance exceeds K, no need to explore further from this path.
        // All subsequent nodes reachable from this path will also have distance > K.
        if (curr_dist > k) {
            continue;
        }

        // Explore neighbors: parent, left child, and right child.

        // Check parent:
        struct TreeNode* parent = parent_map[curr_node->val];
        if (parent != NULL && visited[parent->val] == 0) {
            visited[parent->val] = 1;
            queue[tail].node = parent;
            queue[tail].dist = curr_dist + 1;
            tail++;
        }

        // Check left child:
        if (curr_node->left != NULL && visited[curr_node->left->val] == 0) {
            visited[curr_node->left->val] = 1;
            queue[tail].node = curr_node->left;
            queue[tail].dist = curr_dist + 1;
            tail++;
        }

        // Check right child:
        if (curr_node->right != NULL && visited[curr_node->right->val] == 0) {
            visited[curr_node->right->val] = 1;
            queue[tail].node = curr_node->right;
            queue[tail].dist = curr_dist + 1;
            tail++;
        }
    }

    // Set the return size and return the allocated array.
    *returnSize = result_count;
    return result_arr;
}