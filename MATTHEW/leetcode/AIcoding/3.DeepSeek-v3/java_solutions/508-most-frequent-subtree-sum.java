class Solution {
    private Map<Integer, Integer> sumToCount;
    private int maxCount;

    public int[] findFrequentTreeSum(TreeNode root) {
        sumToCount = new HashMap<>();
        maxCount = 0;
        postOrder(root);
        List<Integer> res = new ArrayList<>();
        for (int key : sumToCount.keySet()) {
            if (sumToCount.get(key) == maxCount) {
                res.add(key);
            }
        }
        int[] result = new int[res.size()];
        for (int i = 0; i < res.size(); i++) {
            result[i] = res.get(i);
        }
        return result;
    }

    private int postOrder(TreeNode root) {
        if (root == null) return 0;
        int left = postOrder(root.left);
        int right = postOrder(root.right);
        int sum = left + right + root.val;
        int count = sumToCount.getOrDefault(sum, 0) + 1;
        sumToCount.put(sum, count);
        maxCount = Math.max(maxCount, count);
        return sum;
    }
}