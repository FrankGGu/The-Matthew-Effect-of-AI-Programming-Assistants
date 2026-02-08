class Solution {
    public boolean verifyPostorder(int[] postorder) {
        return verify(postorder, 0, postorder.length - 1);
    }

    private boolean verify(int[] postorder, int start, int end) {
        if (start >= end) return true;
        int root = postorder[end];
        int i = start;
        while (postorder[i] < root) i++;
        int m = i;
        while (postorder[i] > root) i++;
        return i == end && verify(postorder, start, m - 1) && verify(postorder, m, end - 1);
    }
}