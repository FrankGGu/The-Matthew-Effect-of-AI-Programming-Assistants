#include <stdbool.h>

bool validateBinaryTreeNodes(int n, int* leftChild, int* rightChild) {
    int inDegree[100] = {0};
    for (int i = 0; i < n; i++) {
        if (leftChild[i] != -1) {
            inDegree[leftChild[i]]++;
        }
        if (rightChild[i] != -1) {
            inDegree[rightChild[i]]++;
        }
    }

    int rootCount = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            rootCount++;
        } else if (inDegree[i] > 1) {
            return false;
        }
    }

    return rootCount == 1;
}