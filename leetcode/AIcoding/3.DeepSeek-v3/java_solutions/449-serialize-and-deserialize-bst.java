public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        if (root == null) return "";
        StringBuilder sb = new StringBuilder();
        serializeHelper(root, sb);
        return sb.toString();
    }

    private void serializeHelper(TreeNode node, StringBuilder sb) {
        if (node == null) return;
        sb.append(node.val).append(",");
        serializeHelper(node.left, sb);
        serializeHelper(node.right, sb);
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        if (data.isEmpty()) return null;
        String[] values = data.split(",");
        Queue<Integer> queue = new LinkedList<>();
        for (String val : values) {
            queue.offer(Integer.parseInt(val));
        }
        return deserializeHelper(queue, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    private TreeNode deserializeHelper(Queue<Integer> queue, int lower, int upper) {
        if (queue.isEmpty()) return null;
        int val = queue.peek();
        if (val < lower || val > upper) return null;
        queue.poll();
        TreeNode node = new TreeNode(val);
        node.left = deserializeHelper(queue, lower, val);
        node.right = deserializeHelper(queue, val, upper);
        return node;
    }
}