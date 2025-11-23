public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        serializeHelper(root, sb);
        return sb.toString();
    }

    private void serializeHelper(TreeNode root, StringBuilder sb) {
        if (root == null) {
            sb.append("null").append(",");
            return;
        }
        sb.append(root.val).append(",");
        serializeHelper(root.left, sb);
        serializeHelper(root.right, sb);
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        String[] values = data.split(",");
        int[] index = {0};
        return deserializeHelper(values, index);
    }

    private TreeNode deserializeHelper(String[] values, int[] index) {
        if (values[index[0]].equals("null")) {
            index[0]++;
            return null;
        }
        TreeNode root = new TreeNode(Integer.parseInt(values[index[0]]));
        index[0]++;
        root.left = deserializeHelper(values, index);
        root.right = deserializeHelper(values, index);
        return root;
    }
}