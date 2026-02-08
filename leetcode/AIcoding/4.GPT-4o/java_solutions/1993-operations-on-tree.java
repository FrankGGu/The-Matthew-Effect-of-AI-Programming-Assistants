class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Tree {
    TreeNode root;

    public Tree(int val) {
        root = new TreeNode(val);
    }

    public void addChild(int parent, int child, boolean isLeft) {
        TreeNode parentNode = findNode(root, parent);
        if (parentNode != null) {
            TreeNode childNode = new TreeNode(child);
            if (isLeft) {
                parentNode.left = childNode;
            } else {
                parentNode.right = childNode;
            }
        }
    }

    private TreeNode findNode(TreeNode node, int val) {
        if (node == null) return null;
        if (node.val == val) return node;
        TreeNode left = findNode(node.left, val);
        if (left != null) return left;
        return findNode(node.right, val);
    }

    public List<Integer> getChildren(int val) {
        TreeNode node = findNode(root, val);
        List<Integer> children = new ArrayList<>();
        if (node != null) {
            if (node.left != null) children.add(node.left.val);
            if (node.right != null) children.add(node.right.val);
        }
        return children;
    }
}

class OperationsOnTree {
    private Tree tree;

    public OperationsOnTree(int rootVal) {
        tree = new Tree(rootVal);
    }

    public void addChild(int parent, int child, boolean isLeft) {
        tree.addChild(parent, child, isLeft);
    }

    public List<Integer> getChildren(int val) {
        return tree.getChildren(val);
    }
}