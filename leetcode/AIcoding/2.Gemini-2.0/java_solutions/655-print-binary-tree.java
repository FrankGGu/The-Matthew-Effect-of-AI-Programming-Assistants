class Solution {
    public List<List<String>> printTree(TreeNode root) {
        int height = getHeight(root);
        int width = (int)Math.pow(2, height) - 1;
        List<List<String>> result = new ArrayList<>();
        for (int i = 0; i < height; i++) {
            List<String> row = new ArrayList<>();
            for (int j = 0; j < width; j++) {
                row.add("");
            }
            result.add(row);
        }
        populate(root, result, 0, 0, width - 1);
        return result;
    }

    private int getHeight(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return 1 + Math.max(getHeight(root.left), getHeight(root.right));
    }

    private void populate(TreeNode root, List<List<String>> result, int row, int left, int right) {
        if (root == null) {
            return;
        }
        int mid = (left + right) / 2;
        result.get(row).set(mid, String.valueOf(root.val));
        populate(root.left, result, row + 1, left, mid - 1);
        populate(root.right, result, row + 1, mid + 1, right);
    }
}