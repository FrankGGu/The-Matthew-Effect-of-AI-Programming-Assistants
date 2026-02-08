class Solution {
    public int[] subtreeInversionSum(TreeNode root) {
        int n = countNodes(root);
        int[] result = new int[n];
        int[] index = {0};
        inorderTraversal(root, result, index);
        return result;
    }

    private int countNodes(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return 1 + countNodes(root.left) + countNodes(root.right);
    }

    private void inorderTraversal(TreeNode root, int[] result, int[] index) {
        if (root == null) {
            return;
        }
        inorderTraversal(root.left, result, index);
        result[index[0]++] = calculateInversionSum(root);
        inorderTraversal(root.right, result, index);
    }

    private int calculateInversionSum(TreeNode root) {
        List<Integer> values = new ArrayList<>();
        collectValues(root, values);
        int inversionSum = 0;
        for (int i = 0; i < values.size(); i++) {
            for (int j = i + 1; j < values.size(); j++) {
                if (values.get(i) > values.get(j)) {
                    inversionSum++;
                }
            }
        }
        return inversionSum;
    }

    private void collectValues(TreeNode root, List<Integer> values) {
        if (root == null) {
            return;
        }
        collectValues(root.left, values);
        values.add(root.val);
        collectValues(root.right, values);
    }
}