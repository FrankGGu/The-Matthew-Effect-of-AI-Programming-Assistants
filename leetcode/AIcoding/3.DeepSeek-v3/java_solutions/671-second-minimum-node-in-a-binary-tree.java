class Solution {
    public int findSecondMinimumValue(TreeNode root) {
        if (root == null) return -1;
        Set<Integer> set = new TreeSet<>();
        traverse(root, set);
        if (set.size() < 2) return -1;
        Iterator<Integer> iterator = set.iterator();
        iterator.next();
        return iterator.next();
    }

    private void traverse(TreeNode node, Set<Integer> set) {
        if (node == null) return;
        set.add(node.val);
        traverse(node.left, set);
        traverse(node.right, set);
    }
}