class Solution {
    public int maxDepth(Node root) {
        if (root == null) {
            return 0;
        }

        if (root.children == null || root.children.isEmpty()) {
            return 1;
        }

        int maxChildDepth = 0;
        for (Node child : root.children) {
            maxChildDepth = Math.max(maxChildDepth, maxDepth(child));
        }

        return 1 + maxChildDepth;
    }
}