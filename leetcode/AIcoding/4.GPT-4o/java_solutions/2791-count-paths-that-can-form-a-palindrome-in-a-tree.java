class Solution {
    public int countPalindromicPaths(TreeNode root) {
        return countPalindromicPaths(root, new HashMap<>());
    }

    private int countPalindromicPaths(TreeNode node, Map<Integer, Integer> count) {
        if (node == null) return 0;

        count.put(node.val, count.getOrDefault(node.val, 0) + 1);

        int result = 0;
        if (node.left == null && node.right == null) {
            if (canFormPalindrome(count)) result++;
        } else {
            result += countPalindromicPaths(node.left, count);
            result += countPalindromicPaths(node.right, count);
        }

        count.put(node.val, count.get(node.val) - 1);
        if (count.get(node.val) == 0) count.remove(node.val);

        return result;
    }

    private boolean canFormPalindrome(Map<Integer, Integer> count) {
        int oddCount = 0;
        for (int cnt : count.values()) {
            if (cnt % 2 != 0) oddCount++;
        }
        return oddCount <= 1;
    }
}