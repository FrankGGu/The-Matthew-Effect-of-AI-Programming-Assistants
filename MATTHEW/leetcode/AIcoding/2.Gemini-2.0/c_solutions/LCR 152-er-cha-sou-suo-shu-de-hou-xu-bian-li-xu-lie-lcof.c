#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool verifyPostorderHelper(int* postorder, int start, int end) {
    if (start >= end) {
        return true;
    }

    int rootVal = postorder[end];
    int i = start;
    while (i < end && postorder[i] < rootVal) {
        i++;
    }

    for (int j = i; j < end; j++) {
        if (postorder[j] < rootVal) {
            return false;
        }
    }

    return verifyPostorderHelper(postorder, start, i - 1) && verifyPostorderHelper(postorder, i, end - 1);
}

bool verifyPostorder(int* postorder, int postorderSize) {
    return verifyPostorderHelper(postorder, 0, postorderSize - 1);
}