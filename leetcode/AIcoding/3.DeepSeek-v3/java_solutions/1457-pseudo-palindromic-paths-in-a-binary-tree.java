class Solution {
    private int count = 0;

    public int pseudoPalindromicPaths (TreeNode root) {
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
            if (isPseudoPalindrome(freq)) {
                count++;
            }
        } else {
            dfs(node.left, freq);
            dfs(node.right, freq);
        }
        freq[node.val]--;
    }

    private boolean isPseudoPalindrome(int[] freq) {
        int odd = 0;
        for (int num : freq) {
            if (num % 2 != 0) {
                odd++;
            }
            if (odd > 1) {
                return false;
            }
        }
        return true;
    }
}