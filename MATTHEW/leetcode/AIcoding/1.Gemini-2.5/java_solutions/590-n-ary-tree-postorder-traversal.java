class Solution {
    public List<Integer> postorder(Node root) {
        List<Integer> result = new java.util.ArrayList<>();
        traverse(root, result);
        return result;
    }

    private void traverse(Node node, List<Integer> result) {
        if (node == null) {
            return;
        }

        if (node.children != null) {
            for (Node child : node.children) {
                traverse(child, result);
            }
        }

        result.add(node.val);
    }
}