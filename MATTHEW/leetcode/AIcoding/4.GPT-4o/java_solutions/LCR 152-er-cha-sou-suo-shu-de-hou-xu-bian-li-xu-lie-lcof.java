public class Solution {
    public boolean verifyPostorder(int[] postorder) {
        return verify(postorder, 0, postorder.length - 1);
    }

    private boolean verify(int[] postorder, int left, int right) {
        if (left >= right) return true;
        int root = postorder[right];
        int mid = left;

        while (mid < right && postorder[mid] < root) {
            mid++;
        }

        for (int i = mid; i < right; i++) {
            if (postorder[i] < root) {
                return false;
            }
        }

        return verify(postorder, left, mid - 1) && verify(postorder, mid, right - 1);
    }
}