import java.util.*;

class Solution {
    private int kthLargest;
    private int k;
    private PriorityQueue<Integer> pq;

    public int kthLargestPerfectSubtreeSize(TreeNode root, int k) {
        this.kthLargest = -1;
        this.k = k;
        this.pq = new PriorityQueue<>();
        dfs(root);
        return kthLargest;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftSize = dfs(node.left);
        int rightSize = dfs(node.right);

        if (leftSize == rightSize) {
            int size = leftSize + rightSize + 1;
            pq.offer(size);
            if (pq.size() > k) {
                pq.poll();
            }
        }

        if(pq.size() == k){
            kthLargest = pq.peek();
        }

        return leftSize + rightSize + 1;
    }
}