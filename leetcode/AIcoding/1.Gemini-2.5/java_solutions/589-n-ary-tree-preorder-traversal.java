class Solution {
    public List<Integer> preorder(Node root) {
        List<Integer> result = new java.util.ArrayList<>();
        traverse(root, result);
        return result;
    }

    private void traverse(Node node, List<Integer> result) {
        if (node == null) {
            return;
        }

        result.add(node.val);
        if (node.children != null) {
            for (Node child : node.children) {
                traverse(child, result);
            }
        }
    }
}