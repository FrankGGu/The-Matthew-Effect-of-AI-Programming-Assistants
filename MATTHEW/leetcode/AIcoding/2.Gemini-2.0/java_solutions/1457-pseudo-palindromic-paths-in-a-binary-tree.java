class Solution {
    int count = 0;

    public int pseudoPalindromicPaths(TreeNode root) {
        int[] freq = new int[10];
        dfs(root, freq);
        return count;
    }

    private void dfs(TreeNode node, int[] freq) {
        if (node == null) {
            return;
        }

        freq[node.val]++;

        if (node.left == null && node.right == null) {
            int oddCount = 0;
            for (int i = 1; i <= 9; i++) {
                if (freq[i] % 2 != 0) {
                    oddCount++;
                }
            }
            if (oddCount <= 1) {
                count++;
            }
        } else {
            dfs(node.left, freq);
            dfs(node.right, freq);
        }

        freq[node.val]--;
    }
}