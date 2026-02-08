class Solution {
    private int k;
    private PriorityQueue<Integer> minHeap;

    public int kthLargestPerfectSubtreeSize(TreeNode root) {
        this.k = 0;
        this.minHeap = new PriorityQueue<>();
        dfs(root);
        return minHeap.isEmpty() ? 0 : minHeap.peek();
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }
        int leftSize = dfs(node.left);
        int rightSize = dfs(node.right);
        int totalSize = 1 + leftSize + rightSize;
        if (leftSize == 0 || rightSize == 0) {
            return totalSize;
        }
        if (minHeap.size() < k) {
            minHeap.offer(totalSize);
        } else if (totalSize > minHeap.peek()) {
            minHeap.poll();
            minHeap.offer(totalSize);
        }
        return totalSize;
    }

    public void setK(int k) {
        this.k = k;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}