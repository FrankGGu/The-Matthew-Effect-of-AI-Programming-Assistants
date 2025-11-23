class Solution {
    public int maximizeTheNumberofTargetNodesAfterConnectingTreesII(int n, int[][] edges, int[] target) {
        int targetNodeCount = 0;
        for (int i = 0; i < n; i++) {
            if (target[i] == 1) {
                targetNodeCount++;
            }
        }
        return targetNodeCount;
    }
}