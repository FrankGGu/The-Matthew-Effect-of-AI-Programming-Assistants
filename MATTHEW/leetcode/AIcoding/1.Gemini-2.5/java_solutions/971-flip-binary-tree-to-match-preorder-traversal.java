class Solution {
    List<Integer> ans;
    int idx;
    int[] voyage;

    public List<Integer> flipMatchVoyage(TreeNode root, int[] voyage) {
        this.voyage = voyage;
        this.ans = new ArrayList<>();
        this.idx = 0;

        if (dfs(root)) {
            return ans;
        } else {
            return Arrays.asList(-1);
        }
    }

    private boolean dfs(TreeNode node) {
        if (node == null) {
            return true;
        }

        if (idx >= voyage.length || node.val != voyage[idx]) {
            return false;
        }

        idx++;

        if (node.left != null && idx < voyage.length && node.left.val != voyage[idx]) {
            if (node.right == null || idx >= voyage.length || node.right.val != voyage[idx]) {
                return false;
            }
            ans.add(node.val);
            if (!dfs(node.right)) {
                return false;
            }
            if (!dfs(node.left)) {
                return false;
            }
        } else {
            if (!dfs(node.left)) {
                return false;
            }
            if (!dfs(node.right)) {
                return false;
            }
        }

        return true;
    }
}