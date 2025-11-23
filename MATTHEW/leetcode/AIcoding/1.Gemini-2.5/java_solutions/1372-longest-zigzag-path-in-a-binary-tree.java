class Solution {
    int maxLen = 0;

    public int longestZigZag(TreeNode root) {
        dfs(root);
        return maxLen;
    }

    // This DFS function returns an array of two integers for the current node:
    // result[0]: The length of the longest zigzag path starting from 'node'
    //            and taking its first step to the 'left' child, then alternating.
    //            (i.e., node -> left -> right -> left -> ...)
    // result[1]: The length of the longest zigzag path starting from 'node'
    //            and taking its first step to the 'right' child, then alternating.
    //            (i.e., node -> right -> left -> right -> ...)
    private int[] dfs(TreeNode node) {
        if (node == null) {
            // Base case: A null node cannot extend a path.
            // We use -1 to signify "no path from this direction".
            // When we add 1 to -1, it correctly results in 0,
            // meaning a path of length 0 (no edges) if the child is null.
            return new int[]{-1, -1};
        }

        // Recursively get the zigzag path lengths from the left and right children
        int[] leftChildResult = dfs(node.left);
        int[] rightChildResult = dfs(node.right);

        // Calculate the longest zigzag path starting from 'node' and going left first.
        // This path takes one step 'node -> left' (length 1).
        // To continue zigzag, the path from 'node.left' must then go 'right -> left -> ...'.
        // The length of 'left -> right -> left -> ...' is leftChildResult[1].
        int currentLeftZigZag = 1 + leftChildResult[1];

        // Calculate the longest zigzag path starting from 'node' and going right first.
        // This path takes one step 'node -> right' (length 1).
        // To continue zigzag, the path from 'node.right' must then go 'left -> right -> ...'.
        // The length of 'right -> left -> right -> ...' is rightChildResult[0].
        int currentRightZigZag = 1 + rightChildResult[0];

        // Update the global maximum length found so far.
        // We update maxLen with the paths starting from the current node.
        // Since children also update maxLen, this correctly captures the maximum path
        // regardless of where it starts in the tree.
        maxLen = Math.max(maxLen, currentLeftZigZag);
        maxLen = Math.max(maxLen, currentRightZigZag);

        // Return the calculated zigzag lengths for the current node,
        // to be used by its parent.
        return new int[]{currentLeftZigZag, currentRightZigZag};
    }
}