class Solution {
    public List<List<String>> printTree(TreeNode root) {
        int height = getHeight(root);
        int rows = height + 1;
        int cols = (1 << (height + 1)) - 1;

        List<List<String>> result = new ArrayList<>();
        for (int i = 0; i < rows; i++) {
            List<String> row = new ArrayList<>();
            for (int j = 0; j < cols; j++) {
                row.add("");
            }
            result.add(row);
        }

        fillMatrix(root, 0, (cols - 1) / 2, height, result);

        return result;
    }

    private int getHeight(TreeNode node) {
        if (node == null) {
            return -1;
        }
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }

    private void fillMatrix(TreeNode node, int r, int c, int height, List<List<String>> matrix) {
        if (node == null) {
            return;
        }

        matrix.get(r).set(c, String.valueOf(node.val));

        if (r == height) {
            return;
        }

        int offset = 1 << (height - r - 1);

        if (node.left != null) {
            fillMatrix(node.left, r + 1, c - offset, height, matrix);
        }

        if (node.right != null) {
            fillMatrix(node.right, r + 1, c + offset, height, matrix);
        }
    }
}