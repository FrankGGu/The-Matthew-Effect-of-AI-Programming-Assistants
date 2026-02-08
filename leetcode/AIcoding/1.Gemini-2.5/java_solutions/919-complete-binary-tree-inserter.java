import java.util.LinkedList;
import java.util.Queue;

class CBTInserter {

    private TreeNode root;
    private Queue<TreeNode> parentCandidates;

    public CBTInserter(TreeNode root) {
        this.root = root;
        this.parentCandidates = new LinkedList<>();

        Queue<TreeNode> bfsQueue = new LinkedList<>();
        if (root != null) {
            bfsQueue.offer(root);
        }

        while (!bfsQueue.isEmpty()) {
            TreeNode node = bfsQueue.poll();

            if (node.left == null || node.right == null) {
                parentCandidates.offer(node);
            }

            if (node.left != null) {
                bfsQueue.offer(node.left);
            }
            if (node.right != null) {
                bfsQueue.offer(node.right);
            }
        }
    }

    public int insert(int val) {
        TreeNode parent = parentCandidates.peek();
        TreeNode newNode = new TreeNode(val);

        if (parent.left == null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            parentCandidates.poll(); // Parent is now full, remove it
        }
        parentCandidates.offer(newNode); // New node is a potential parent for future insertions
        return parent.val;
    }

    public TreeNode get_root() {
        return root;
    }
}