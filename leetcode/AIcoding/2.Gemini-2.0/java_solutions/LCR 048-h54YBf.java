import java.util.*;

public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        if (root == null) {
            return "null,";
        }
        return root.val + "," + serialize(root.left) + serialize(root.right);
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        Queue<String> q = new LinkedList<>(Arrays.asList(data.split(",")));
        return deserializeHelper(q);
    }

    private TreeNode deserializeHelper(Queue<String> q) {
        String s = q.poll();
        if (s.equals("null")) {
            return null;
        }
        TreeNode root = new TreeNode(Integer.parseInt(s));
        root.left = deserializeHelper(q);
        root.right = deserializeHelper(q);
        return root;
    }
}