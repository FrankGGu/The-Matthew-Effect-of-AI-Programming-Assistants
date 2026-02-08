#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool findPath(struct TreeNode* node, int target, char* path, int* pathIdx) {
    if (node == NULL) {
        return false;
    }

    if (node->val == target) {
        return true;
    }

    // Try finding the target in the left subtree
    path[*pathIdx] = 'L';
    (*pathIdx)++;
    if (findPath(node->left, target, path, pathIdx)) {
        return true;
    }
    (*pathIdx)--; // Backtrack: remove 'L' if target not found in left subtree

    // Try finding the target in the right subtree
    path[*pathIdx] = 'R';
    (*pathIdx)++;
    if (findPath(node->right, target, path, pathIdx)) {
        return true;
    }
    (*pathIdx)--; // Backtrack: remove 'R' if target not found in right subtree

    return false;
}

char* getDirections(struct TreeNode* root, int startValue, int destValue) {
    // Max path length for N nodes is N-1. N can be up to 10^5.
    // Allocate buffers large enough to hold the longest possible path.
    char pathToStart[100005]; // Buffer for path from root to startValue
    char pathToDest[100005];  // Buffer for path from root to destValue
    int pathToStartIdx = 0;   // Current length of pathToStart
    int pathToDestIdx = 0;    // Current length of pathToDest

    // Find the path from the root to the startValue node
    findPath(root, startValue, pathToStart, &pathToStartIdx);
    // Find the path from the root to the destValue node
    findPath(root, destValue, pathToDest, &pathToDestIdx);

    // Determine the length of the common prefix between pathToStart and pathToDest.
    // This common prefix represents the path from the root to the Lowest Common Ancestor (LCA).
    int commonPrefixLen = 0;
    while (commonPrefixLen < pathToStartIdx && commonPrefixLen < pathToDestIdx &&
           pathToStart[commonPrefixLen] == pathToDest[commonPrefixLen]) {
        commonPrefixLen++;
    }

    // Calculate the total length of the final direction string.
    // 1. Path from startValue to LCA: Each step in the unique part of pathToStart
    //    needs to be an 'U' (Up) move. The length is (pathToStartIdx - commonPrefixLen).
    // 2. Path from LCA to destValue: This is the unique part of pathToDest,
    //    starting from the LCA. The length is (pathToDestIdx - commonPrefixLen).
    int resultLen = (pathToStartIdx - commonPrefixLen) + (pathToDestIdx - commonPrefixLen);

    // Allocate memory for the result string (+1 for the null terminator).
    char* result = (char*)malloc(sizeof(char) * (resultLen + 1));
    if (result == NULL) {
        return NULL; // Handle memory allocation failure
    }

    int currentResultIdx = 0;

    // Append 'U' characters for the path from startValue up to the LCA.
    for (int i = 0; i < pathToStartIdx - commonPrefixLen; i++) {
        result[currentResultIdx++] = 'U';
    }

    // Append the path characters from the LCA down to the destValue.
    // These are the characters in pathToDest after the common prefix.
    for (int i = commonPrefixLen; i < pathToDestIdx; i++) {
        result[currentResultIdx++] = pathToDest[i];
    }

    // Null-terminate the result string.
    result[currentResultIdx] = '\0';

    return result;
}