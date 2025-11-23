import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    private List<Integer> sortedValues;

    private void inorderTraversal(TreeNode node) {
        if (node == null) {
            return;
        }
        inorderTraversal(node.left);
        sortedValues.add(node.val);
        inorderTraversal(node.right);
    }

    public List<List<Integer>> closestNodes(TreeNode root, List<Integer> queries) {
        sortedValues = new ArrayList<>();
        inorderTraversal(root);

        List<List<Integer>> results = new ArrayList<>();

        for (int query : queries) {
            int minVal = -1;
            int maxVal = -1;

            int idx = Collections.binarySearch(sortedValues, query);

            if (idx >= 0) {
                minVal = sortedValues.get(idx);
                maxVal = sortedValues.get(idx);
            } else {
                int insertionPoint = -idx - 1;

                if (insertionPoint > 0) {
                    maxVal = sortedValues.get(insertionPoint - 1);
                }

                if (insertionPoint < sortedValues.size()) {
                    minVal = sortedValues.get(insertionPoint);
                }
            }

            List<Integer> currentResult = new ArrayList<>();
            currentResult.add(maxVal);
            currentResult.add(minVal);
            results.add(currentResult);
        }

        return results;
    }
}