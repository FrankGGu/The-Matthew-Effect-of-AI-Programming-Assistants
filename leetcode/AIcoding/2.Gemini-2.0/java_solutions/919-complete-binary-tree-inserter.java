import java.util.LinkedList;
import java.util.Queue;

class CBTInserter {

    TreeNode root;
    Queue<TreeNode> queue;

    public CBTInserter(TreeNode root) {
        this.root = root;
        queue = new LinkedList<>();
        Queue<TreeNode> tempQueue = new LinkedList<>();
        tempQueue.offer(root);

        while (!tempQueue.isEmpty()) {
            TreeNode node = tempQueue.poll();
            if (node.left == null || node.right == null) {
                queue.offer(node);
            }
            if (node.left != null) {
                tempQueue.offer(node.left);
            }
            if (node.right != null) {
                tempQueue.offer(node.right);
            }
        }
    }

    public int insert(int val) {
        TreeNode newNode = new TreeNode(val);
        TreeNode parent = queue.peek();
        if (parent.left == null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            queue.poll();
        }
        queue.offer(newNode);
        return parent.val;
    }

    public TreeNode get_root() {
        return root;
    }
}