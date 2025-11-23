import java.util.ArrayList;
import java.util.List;

class Solution {
    private int count = 0;

    public int countPairs(TreeNode root, int distance) {
        dfs(root, distance);
        return count;
    }

    private List<Integer> dfs(TreeNode node, int distance) {
        if (node == null) {
            return new ArrayList<>();
        }

        if (node.left == null && node.right == null) { // Leaf node
            List<Integer> leafDistance = new ArrayList<>();
            leafDistance.add(1); // Distance from parent to this leaf is 1
            return leafDistance;
        }

        List<Integer> leftDistances = dfs(node.left, distance);
        List<Integer> rightDistances = dfs(node.right, distance);

        // Check for good pairs between left and right subtrees
        for (int ld : leftDistances) {
            for (int rd : rightDistances) {
                if (ld + rd <= distance) {
                    count++;
                }
            }
        }

        // Prepare distances for the current node's parent
        List<Integer> currentDistances = new ArrayList<>();
        for (int ld : leftDistances) {
            if (ld + 1 <= distance) { // Only propagate distances that are still within the max distance
                currentDistances.add(ld + 1);
            }
        }
        for (int rd : rightDistances) {
            if (rd + 1 <= distance) { // Only propagate distances that are still within the max distance
                currentDistances.add(rd + 1);
            }
        }

        return currentDistances;
    }
}