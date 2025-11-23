class CBTInserter {
    private TreeNode root;
    private Queue<TreeNode> queue;

    public CBTInserter(TreeNode root) {
        this.root = root;
        queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            TreeNode node = queue.peek();
            if (node.left != null && node.right != null) {
                queue.poll();
                queue.offer(node.left);
                queue.offer(node.right);
            } else {
                if (node.left != null) {
                    queue.offer(node.left);
                }
                break;
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
            queue.offer(node.left);
            queue.offer(node.right);
        }
        return node.val;
    }

    public TreeNode get_root() {
        return root;
    }
}