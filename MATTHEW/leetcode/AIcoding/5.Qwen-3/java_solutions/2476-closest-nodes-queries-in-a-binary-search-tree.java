public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> closestNodes(TreeNode root, List<Integer> queries) {
        List<Integer> sortedValues = new ArrayList<>();
        inOrderTraversal(root, sortedValues);

        List<List<Integer>> result = new ArrayList<>();
        for (int query : queries) {
            int left = -1;
            int right = -1;
            int low = 0, high = sortedValues.size() - 1;

            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (sortedValues.get(mid) < query) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            if (low < sortedValues.size()) {
                right = sortedValues.get(low);
            }
            if (low > 0) {
                left = sortedValues.get(low - 1);
            }
            result.add(Arrays.asList(left, right));
        }
        return result;
    }

    private void inOrderTraversal(TreeNode node, List<Integer> list) {
        if (node == null) return;
        inOrderTraversal(node.left, list);
        list.add(node.val);
        inOrderTraversal(node.right, list);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}