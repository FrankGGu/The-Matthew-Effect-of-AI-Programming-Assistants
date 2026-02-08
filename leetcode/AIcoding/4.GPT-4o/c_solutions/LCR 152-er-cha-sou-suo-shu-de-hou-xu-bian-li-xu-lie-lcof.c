bool verifyPostorder(int* postorder, int postorderSize) {
    if (postorderSize <= 1) return true;

    int root = postorder[postorderSize - 1];
    int i = 0;

    while (i < postorderSize - 1 && postorder[i] < root) {
        i++;
    }

    int j = i;
    while (j < postorderSize - 1) {
        if (postorder[j] < root) return false;
        j++;
    }

    return verifyPostorder(postorder, i) && verifyPostorder(postorder + i, postorderSize - i - 1);
}