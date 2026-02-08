import java.util.LinkedList;
import java.util.Queue;

public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        if (root == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        serializeHelper(root, sb);
        // Remove the trailing comma
        return sb.substring(0, sb.length() - 1);
    }

    private void serializeHelper(TreeNode node, StringBuilder sb) {
        if (node == null) {
            return;
        }
        sb.append(node.val).append(",");
        serializeHelper(node.left, sb);
        serializeHelper(node.right, sb);
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        if (data == null || data.isEmpty()) {
            return null;
        }

        // Use a Queue to easily manage the pre-order traversal elements
        // Split by comma and parse integers
        Queue<Integer> q = new LinkedList<>();
        for (String s : data.split(",")) {
            q.offer(Integer.parseInt(s));
        }

        // Start deserialization with the widest possible bounds for the root
        return deserializeHelper(q, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    private TreeNode deserializeHelper(Queue<Integer> q, int lower_bound, int upper_bound) {
        // If no more elements in the queue, this path ends.
        if (q.isEmpty()) {
            return null;
        }

        int val = q.peek();

        // If the current value is outside the allowed range for this subtree,
        // it means this value belongs to an ancestor's right subtree (if too small)
        // or an ancestor's left subtree (if too large).
        // In pre-order, this value would be processed later by the correct recursive call.
        // So, we don't consume it here and return null, allowing the parent to try its right child.
        if (val < lower_bound || val > upper_bound) {
            return null;
        }

        q.poll(); // Consume the value, it's the root of the current subtree
        TreeNode node = new TreeNode(val);

        // Recursively build the left subtree: values must be greater than lower_bound and less than current node's value
        node.left = deserializeHelper(q, lower_bound, val);

        // Recursively build the right subtree: values must be greater than current node's value and less than upper_bound
        node.right = deserializeHelper(q, val, upper_bound);

        return node;
    }
}