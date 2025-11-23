class Solution {
    public boolean verifyPostorder(int[] postorder) {
        if (postorder == null || postorder.length == 0) {
            return true;
        }
        return verify(postorder, 0, postorder.length - 1);
    }

    private boolean verify(int[] postorder, int i, int j) {
        if (i >= j) {
            return true;
        }

        int rootVal = postorder[j];

        int k = i;
        while (k < j && postorder[k] < rootVal) {
            k++;
        }

        int p = k;
        while (p < j) {
            if (postorder[p] <= rootVal) {
                return false;
            }
            p++;
        }

        boolean leftIsValid = verify(postorder, i, k - 1);
        boolean rightIsValid = verify(postorder, k, j - 1);

        return leftIsValid && rightIsValid;
    }
}