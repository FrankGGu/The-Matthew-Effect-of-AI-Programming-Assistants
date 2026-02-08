class Solution {
    private int currentVal;
    private int currentCount = 0;
    private int maxCount = 0;
    private List<Integer> modes = new ArrayList<>();

    public int[] findMode(TreeNode root) {
        inorder(root);
        int[] result = new int[modes.size()];
        for (int i = 0; i < modes.size(); i++) {
            result[i] = modes.get(i);
        }
        return result;
    }

    private void inorder(TreeNode node) {
        if (node == null) return;
        inorder(node.left);
        handleValue(node.val);
        inorder(node.right);
    }

    private void handleValue(int val) {
        if (val != currentVal) {
            currentVal = val;
            currentCount = 0;
        }
        currentCount++;
        if (currentCount > maxCount) {
            maxCount = currentCount;
            modes.clear();
            modes.add(currentVal);
        } else if (currentCount == maxCount) {
            modes.add(currentVal);
        }
    }
}