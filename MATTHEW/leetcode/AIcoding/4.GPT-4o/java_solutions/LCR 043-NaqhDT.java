class CBTInserter {
    private TreeNode root;
    private Queue<TreeNode> queue;

    public CBTInserter(TreeNode root) {
        this.root = root;
        this.queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            TreeNode node = queue.peek();
            if (node.left != null) {
                queue.add(node.left);
            }
            if (node.right != null) {
                queue.add(node.right);
            }
            if (node.left == null || node.right == null) {
                break;
            }
            queue.poll();
        }
    }

    public int insert(int v) {
        TreeNode newNode = new TreeNode(v);
        TreeNode parent = queue.peek();
        if (parent.left == null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            queue.poll();
        }
        queue.add(newNode);
        return parent.val;
    }

    public TreeNode get_root() {
        return root;
    }
}