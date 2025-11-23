#include <stdbool.h>

bool verify(int* postorder, int start, int end) {
    if (start >= end) {
        return true;
    }

    int root = postorder[end];

    int i = start;
    while (i < end && postorder[i] < root) {
        i++;
    }

    int j = i;
    while (j < end && postorder[j] > root) {
        j++;
    }

    if (j != end) {
        return false;
    }

    return verify(postorder, start, i - 1) && verify(postorder, i, end - 1);
}

bool verifyPostorder(int* postorder, int postorderSize) {
    if (postorderSize == 0) {
        return true;
    }
    return verify(postorder, 0, postorderSize - 1);
}