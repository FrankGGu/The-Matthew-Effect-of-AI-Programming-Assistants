class CBTInserter {
    private TreeNode root;
    private Queue<TreeNode> queue;

    public CBTInserter(TreeNode root) {
        this.root = root;
        queue = new LinkedList<>();
        Queue<TreeNode> temp = new LinkedList<>();
        temp.offer(root);
        while (!temp.isEmpty()) {
            TreeNode node = temp.poll();
            if (node.left == null || node.right == null) {
                queue.offer(node);
            }
            if (node.left != null) {
                temp.offer(node.left);
            }
            if (node.right != null) {
                temp.offer(node.right);
            }
        }
    }

    public int insert(int val) {
        TreeNode node = queue.peek();
        TreeNode newNode = new TreeNode(val);
        if (node.left == null) {
            node.left = newNode;
        } else {
            node.right = newNode;
            queue.poll();
        }
        queue.offer(newNode);
        return node.val;
    }

    public TreeNode get_root() {
        return root;
    }
}