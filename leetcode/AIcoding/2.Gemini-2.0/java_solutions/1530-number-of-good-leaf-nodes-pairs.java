class Solution {
    int count = 0;
    int distance;

    public int countPairs(TreeNode root, int distance) {
        this.distance = distance;
        dfs(root);
        return count;
    }

    private List<Integer> dfs(TreeNode node) {
        List<Integer> distances = new ArrayList<>();

        if (node == null) {
            return distances;
        }

        if (node.left == null && node.right == null) {
            distances.add(1);
            return distances;
        }

        List<Integer> leftDistances = dfs(node.left);
        List<Integer> rightDistances = dfs(node.right);

        for (int leftDistance : leftDistances) {
            for (int rightDistance : rightDistances) {
                if (leftDistance + rightDistance <= distance) {
                    count++;
                }
            }
        }

        for (int leftDistance : leftDistances) {
            if (leftDistance + 1 <= distance) {
                distances.add(leftDistance + 1);
            }
        }

        for (int rightDistance : rightDistances) {
            if (rightDistance + 1 <= distance) {
                distances.add(rightDistance + 1);
            }
        }

        return distances;
    }
}