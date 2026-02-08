char* getDirections(struct TreeNode* root, int startValue, int destValue) {
    // Function to find the path from the root to a given value
    char* path = (char*)malloc(1000 * sizeof(char));
    char* pathToStart = (char*)malloc(1000 * sizeof(char));
    char* pathToDest = (char*)malloc(1000 * sizeof(char));
    int lenStart = 0, lenDest = 0;

    // Helper function to find the path
    void findPath(struct TreeNode* node, int value, char* currentPath, int* pathLength) {
        if (!node) return;
        currentPath[(*pathLength)++] = 'L';
        if (node->left && (node->left->val == value || findPath(node->left, value, currentPath, pathLength))) return;
        currentPath[--(*pathLength)] = 'R';
        currentPath[(*pathLength)++] = 'R';
        if (node->right && (node->right->val == value || findPath(node->right, value, currentPath, pathLength))) return;
        currentPath[--(*pathLength)] = 0;
    }

    findPath(root, startValue, pathToStart, &lenStart);
    findPath(root, destValue, pathToDest, &lenDest);

    int i = 0;
    while (i < lenStart && i < lenDest && pathToStart[i] == pathToDest[i]) i++;

    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;

    for (int j = i; j < lenStart; j++) {
        result[index++] = 'U';
    }

    for (int j = i; j < lenDest; j++) {
        result[index++] = pathToDest[j];
    }

    result[index] = '\0';

    free(path);
    free(pathToStart);
    free(pathToDest);

    return result;
}