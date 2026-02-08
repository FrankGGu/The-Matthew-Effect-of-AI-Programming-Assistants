import java.util.LinkedList;
import java.util.Queue;

class CBTInserter {

    private TreeNode root;
    private Queue<TreeNode> candidates;

    public CBTInserter(TreeNode root) {
        this.root = root;
        this.candidates = new LinkedList<>();

        Queue<TreeNode> q = new LinkedList<>();
        q.offer(root);

        while (!q.isEmpty()) {
            TreeNode node = q.poll();

            if (node.left != null) {
                q.offer(node.left);
            }
            if (node.right != null) {
                q.offer(node.right);
            }

            if (node.left == null || node.right == null) {
                candidates.offer(node);
            }
        }
    }

    public int insert(int v) {
        TreeNode parent = candidates.peek();
        TreeNode newNode = new TreeNode(v);

        if (parent.left == null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            candidates.poll();
        }

        candidates.offer(newNode);
        return parent.val;
    }

    public TreeNode get_root() {
        return this.root;
    }
}