public class Solution {

import java.util.*;

public class CBTInserter {
    private TreeNode root;
    private Queue<TreeNode> queue;

    public CBTInserter(TreeNode root) {
        this.root = root;
        this.queue = new LinkedList<>();
        Queue<TreeNode> temp = new LinkedList<>();
        temp.add(root);
        while (!temp.isEmpty()) {
            TreeNode node = temp.poll();
            if (node.left != null) {
                temp.add(node.left);
            }
            if (node.right != null) {
                temp.add(node.right);
            }
            if (node.left == null || node.right == null) {
                queue.add(node);
            }
        }
    }

    public TreeNode insert(int val) {
        TreeNode newNode = new TreeNode(val);
        TreeNode parent = queue.peek();
        if (parent.left == null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            queue.poll();
            if (parent.left != null) {
                queue.add(parent.left);
            }
            if (parent.right != null) {
                queue.add(parent.right);
            }
        }
        return newNode;
    }

    public TreeNode get_root() {
        return root;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}