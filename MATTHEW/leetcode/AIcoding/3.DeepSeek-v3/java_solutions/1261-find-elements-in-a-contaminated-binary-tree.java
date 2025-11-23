class FindElements {
    private Set<Integer> elements;

    public FindElements(TreeNode root) {
        elements = new HashSet<>();
        recover(root, 0);
    }

    private void recover(TreeNode node, int val) {
        if (node == null) return;
        node.val = val;
        elements.add(val);
        recover(node.left, 2 * val + 1);
        recover(node.right, 2 * val + 2);
    }

    public boolean find(int target) {
        return elements.contains(target);
    }
}