class Solution {
    private int currentVal;
    private int currentCount;
    private int maxCount;
    private List<Integer> modes;

    public int[] findMode(TreeNode root) {
        if (root == null) {
            return new int[0];
        }

        currentVal = 0;
        currentCount = 0;
        maxCount = 0;
        modes = new ArrayList<>();

        inorderTraversalPass1(root);

        currentVal = 0;
        currentCount = 0;
        modes.clear();

        inorderTraversalPass2(root);

        int[] result = new int[modes.size()];
        for (int i = 0; i < modes.size(); i++) {
            result[i] = modes.get(i);
        }
        return result;
    }

    private void inorderTraversalPass1(TreeNode node) {
        if (node == null) {
            return;
        }

        inorderTraversalPass1(node.left);

        if (node.val == currentVal) {
            currentCount++;
        } else {
            currentVal = node.val;
            currentCount = 1;
        }
        maxCount = Math.max(maxCount, currentCount);

        inorderTraversalPass1(node.right);
    }

    private void inorderTraversalPass2(TreeNode node) {
        if (node == null) {
            return;
        }

        inorderTraversalPass2(node.left);

        if (node.val == currentVal) {
            currentCount++;
        } else {
            currentVal = node.val;
            currentCount = 1;
        }

        if (currentCount == maxCount) {
            modes.add(currentVal);
        }

        inorderTraversalPass2(node.right);
    }
}