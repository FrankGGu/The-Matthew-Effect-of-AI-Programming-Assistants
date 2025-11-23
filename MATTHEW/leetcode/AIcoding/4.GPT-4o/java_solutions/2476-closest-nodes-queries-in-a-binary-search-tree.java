import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class BSTIterator {
    private Stack<TreeNode> stack;

    public BSTIterator(TreeNode root) {
        stack = new Stack<>();
        pushLeft(root);
    }

    private void pushLeft(TreeNode node) {
        while (node != null) {
            stack.push(node);
            node = node.left;
        }
    }

    public boolean hasNext() {
        return !stack.isEmpty();
    }

    public TreeNode next() {
        TreeNode node = stack.pop();
        pushLeft(node.right);
        return node;
    }
}

class Solution {
    private List<Integer> values;

    public List<List<Integer>> closestNodes(TreeNode root, List<Integer> queries) {
        values = new ArrayList<>();
        inOrderTraversal(root);
        List<List<Integer>> result = new ArrayList<>();

        for (int query : queries) {
            result.add(findClosest(query));
        }

        return result;
    }

    private void inOrderTraversal(TreeNode node) {
        if (node == null) return;
        inOrderTraversal(node.left);
        values.add(node.val);
        inOrderTraversal(node.right);
    }

    private List<Integer> findClosest(int query) {
        int left = Collections.binarySearch(values, query);
        List<Integer> result = new ArrayList<>();

        if (left >= 0) {
            result.add(query);
            result.add(query);
        } else {
            int insertPoint = -(left + 1);
            if (insertPoint > 0) {
                result.add(values.get(insertPoint - 1));
            } else {
                result.add(-1);
            }
            if (insertPoint < values.size()) {
                result.add(values.get(insertPoint));
            } else {
                result.add(-1);
            }
        }

        return result;
    }
}