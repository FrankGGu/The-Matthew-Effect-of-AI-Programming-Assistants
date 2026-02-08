import java.util.*;

class Solution {
    public int[] treeQueries(TreeNode root, int[] queries) {
        Map<TreeNode, Integer> depth = new HashMap<>();
        Map<TreeNode, Integer> height = new HashMap<>();
        depth.put(null, -1);
        height.put(null, -1);

        dfs(root, 0, depth, height);

        Map<TreeNode, Integer> leftMax = new HashMap<>();
        Map<TreeNode, Integer> rightMax = new HashMap<>();
        leftMax.put(null, -1);
        rightMax.put(null, -1);

        calculateMaxHeights(root, leftMax, rightMax, depth, height);

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            TreeNode target = findNode(root, queries[i]);
            if (target == root) {
                result[i] = height.getOrDefault(root, 0) - 1;
            } else {
                result[i] = findHeightAfterRemoval(root, target, depth, height, leftMax, rightMax);
            }
        }
        return result;
    }

    private int findHeightAfterRemoval(TreeNode root, TreeNode target, Map<TreeNode, Integer> depth, Map<TreeNode, Integer> height, Map<TreeNode, Integer> leftMax, Map<TreeNode, Integer> rightMax) {
        int maxHeight = 0;
        TreeNode curr = target;
        Deque<TreeNode> path = new ArrayDeque<>();
        while (curr != null) {
            path.push(curr);
            curr = findParent(root, curr);
        }
        TreeNode prev = null;
        while (!path.isEmpty()) {
            TreeNode node = path.pop();
            if (prev == null) {
                if (findParent(root, node) != null) {
                    TreeNode parent = findParent(root, node);
                    if (parent.left == node) {
                        maxHeight = Math.max(maxHeight, height.getOrDefault(parent.right, -1) + depth.getOrDefault(parent, 0) + 1);
                    } else {
                        maxHeight = Math.max(maxHeight, height.getOrDefault(parent.left, -1) + depth.getOrDefault(parent, 0) + 1);
                    }
                    prev = node;
                }
            } else {
                if (findParent(root, node) != null) {
                    TreeNode parent = findParent(root, node);
                    if (parent.left == node) {
                        maxHeight = Math.max(maxHeight, Math.max(height.getOrDefault(parent.right, -1) + depth.getOrDefault(parent, 0) + 1, rightMax.getOrDefault(parent, -1)));
                    } else {
                        maxHeight = Math.max(maxHeight, Math.max(height.getOrDefault(parent.left, -1) + depth.getOrDefault(parent, 0) + 1, leftMax.getOrDefault(parent, -1)));
                    }
                    prev = node;
                }
            }
        }
        return maxHeight;
    }

    private TreeNode findParent(TreeNode root, TreeNode node) {
        if (root == null || root == node) {
            return null;
        }
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            TreeNode curr = queue.poll();
            if (curr.left == node || curr.right == node) {
                return curr;
            }
            if (curr.left != null) {
                queue.offer(curr.left);
            }
            if (curr.right != null) {
                queue.offer(curr.right);
            }
        }
        return null;
    }

    private void calculateMaxHeights(TreeNode root, Map<TreeNode, Integer> leftMax, Map<TreeNode, Integer> rightMax, Map<TreeNode, Integer> depth, Map<TreeNode, Integer> height) {
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();
            if (node.left != null) {
                leftMax.put(node.left, Math.max(leftMax.getOrDefault(node, -1), height.getOrDefault(node.right, -1) + depth.getOrDefault(node, 0) + 1));
                queue.offer(node.left);
            }
            if (node.right != null) {
                rightMax.put(node.right, Math.max(rightMax.getOrDefault(node, -1), height.getOrDefault(node.left, -1) + depth.getOrDefault(node, 0) + 1));
                queue.offer(node.right);
            }
        }
    }

    private void dfs(TreeNode node, int d, Map<TreeNode, Integer> depth, Map<TreeNode, Integer> height) {
        if (node == null) {
            return;
        }
        depth.put(node, d);
        dfs(node.left, d + 1, depth, height);
        dfs(node.right, d + 1, depth, height);
        height.put(node, Math.max(height.getOrDefault(node.left, -1), height.getOrDefault(node.right, -1)) + 1);
    }

    private TreeNode findNode(TreeNode root, int val) {
        if (root == null) {
            return null;
        }
        if (root.val == val) {
            return root;
        }
        TreeNode left = findNode(root.left, val);
        if (left != null) {
            return left;
        }
        return findNode(root.right, val);
    }
}