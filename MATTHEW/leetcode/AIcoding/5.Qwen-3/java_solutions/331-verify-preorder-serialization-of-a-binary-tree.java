public class Solution {
    public boolean verifyPreorder(int[] preorder) {
        int index = -1;
        for (int node : preorder) {
            while (index >= 0 && preorder[index] < node) {
                index--;
            }
            index++;
        }
        return index == preorder.length - 1;
    }
}