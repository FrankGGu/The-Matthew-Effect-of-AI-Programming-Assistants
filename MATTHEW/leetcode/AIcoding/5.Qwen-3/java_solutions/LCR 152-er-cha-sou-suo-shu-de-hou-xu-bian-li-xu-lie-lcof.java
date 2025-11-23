public class Solution {
    public boolean verifyPostorder(int[] postorder) {
        return verify(postorder, 0, postorder.length - 1);
    }

    private boolean verify(int[] postorder, int left, int right) {
        if (left >= right) {
            return true;
        }
        int root = postorder[right];
        int i = left;
        while (i < right && postorder[i] < root) {
            i++;
        }
        int j = i;
        while (j < right) {
            if (postorder[j] < root) {
                return false;
            }
            j++;
        }
        return verify(postorder, left, i - 1) && verify(postorder, i, right - 1);
    }
}