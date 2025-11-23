class Solution {
    int count = 0;

    public int countPairs(TreeNode root, int distance) {
        dfs(root, distance);
        return count;
    }

    private List<Integer> dfs(TreeNode node, int distance) {
        if (node == null) {
            return new ArrayList<>();
        }
        if (node.left == null && node.right == null) {
            List<Integer> leaf = new ArrayList<>();
            leaf.add(1);
            return leaf;
        }

        List<Integer> leftLeaves = dfs(node.left, distance);
        List<Integer> rightLeaves = dfs(node.right, distance);

        for (int left : leftLeaves) {
            for (int right : rightLeaves) {
                if (left + right <= distance) {
                    count++;
                }
            }
        }

        List<Integer> mergedLeaves = new ArrayList<>();
        for (int left : leftLeaves) {
            if (left + 1 < distance) {
                mergedLeaves.add(left + 1);
            }
        }
        for (int right : rightLeaves) {
            if (right + 1 < distance) {
                mergedLeaves.add(right + 1);
            }
        }

        return mergedLeaves;
    }
}