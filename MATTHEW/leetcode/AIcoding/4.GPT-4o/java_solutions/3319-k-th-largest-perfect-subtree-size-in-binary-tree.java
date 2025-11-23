import java.util.*;

class Solution {
    public int kthLargest(TreeNode root, int k) {
        List<Integer> sizes = new ArrayList<>();
        calculateSizes(root, sizes);
        Collections.sort(sizes, Collections.reverseOrder());
        return sizes.size() >= k ? sizes.get(k - 1) : -1;
    }

    private int calculateSizes(TreeNode node, List<Integer> sizes) {
        if (node == null) return 0;
        int leftSize = calculateSizes(node.left, sizes);
        int rightSize = calculateSizes(node.right, sizes);
        int currentSize = leftSize + rightSize + 1;
        sizes.add(currentSize);
        return currentSize;
    }
}